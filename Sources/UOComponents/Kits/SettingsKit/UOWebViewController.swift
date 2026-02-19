//
//  UOWebViewController.swift
//  UOComponents
//
//  Created by Ünsal Öner on 16.02.2026.
//

import WebKit
import UIKit
import SnapKit

public final class UOWebViewController: UIViewController {

    private let url: URL
    private let pageTitle: String

    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let wv = WKWebView(frame: .zero, configuration: config)
        wv.navigationDelegate = self
        wv.backgroundColor = UOColor.background
        wv.isOpaque = false
        wv.scrollView.backgroundColor = UOColor.background
        return wv
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = UOColor.textPrimary
        indicator.hidesWhenStopped = true
        return indicator
    }()

    public init(url: URL, title: String) {
        self.url = url
        self.pageTitle = title
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        webView.load(URLRequest(url: url))
    }

    private func setupUI() {
        view.backgroundColor = UOColor.background
        self.title = pageTitle

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UOColor.background
        appearance.titleTextAttributes = [
            .foregroundColor: UOColor.textPrimary,
            .font: UOFont.title(17)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = UOColor.textPrimary

        view.addSubview(webView)
        view.addSubview(activityIndicator)

        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    // MARK: - Dark Mode CSS Injection

    private func injectDarkModeCSS() {
        let darkModeCSS = """
        (function() {
            var style = document.createElement('style');
            style.type = 'text/css';
            style.innerHTML = `
                * {
                    background-color: #0A0A0F !important;
                    color: #E5E7EB !important;
                    border-color: #374151 !important;
                }
                body {
                    background-color: #0A0A0F !important;
                    color: #E5E7EB !important;
                }
                a {
                    color: #60A5FA !important;
                }
                h1, h2, h3, h4, h5, h6 {
                    color: #FFFFFF !important;
                }
                p, li, span, div {
                    color: #D1D5DB !important;
                }
                img {
                    opacity: 0.9;
                }
            `;
            document.head.appendChild(style);
        })();
        """

        webView.evaluateJavaScript(darkModeCSS, completionHandler: nil)
    }
}

// MARK: - WKNavigationDelegate

extension UOWebViewController: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        injectDarkModeCSS()
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
