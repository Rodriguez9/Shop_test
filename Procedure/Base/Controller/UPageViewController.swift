//
//  UPageViewController.swift
//  shop_test
//
//  Created by 姚智豪 on 2020/3/30.
//  Copyright © 2020 姚智豪. All rights reserved.
//

import UIKit
import HMSegmentedControl

enum UPageStyle {
    case none
    case navgationBarSegment
    case topTabBar
}

class UPageViewController: UBaseViewController {
    
    var pageStyle: UPageStyle!
    
    //HMSegmentedControl：分栏控制器
    //then:来源于第三方框架Then，改进写法
    //上面的那几个标题名
    lazy var segment: HMSegmentedControl = {
        return HMSegmentedControl().then {
            $0.addTarget(self, action: #selector(changeIndex(segment:)), for: .valueChanged)
        }
    }()
    
    //UIPageViewController是一个用来管理内容页之间导航的容器控制器(container view controller)，其中每个子页面由子视图控制器管理。内容页间导航可以由用户手势触发，也可以由代码控制。
    //UIPageViewController可以实现图片轮播效果和翻书效果.
    //transitionStyle ： 翻页的过渡样式
    //navigationOrientation ： 导航方向
    //options： 这个参数是可选的,传入的是对UIPageViewController的一些配置
    lazy var pageVC: UIPageViewController = {
        return UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }()
    
    private(set) var vcs: [UIViewController]!
    private(set) var titles:[String]!
    //分栏控制器被选择的那个
    private var currentSelectIndex: Int = 0

    convenience init(titles:[String] = [],vcs: [UIViewController] = [],pageStyle: UPageStyle = .none) {
        self.init()
        self.titles = titles
        self.vcs = vcs
        self.pageStyle = pageStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func changeIndex(segment: UISegmentedControl){
        let index = segment.selectedSegmentIndex
        if currentSelectIndex != index {
            let target:[UIViewController] = [vcs[index]]
            //向左移动还是向右移动
            let direction: UIPageViewController.NavigationDirection = currentSelectIndex > index ? .reverse : .forward
            pageVC.setViewControllers(target, direction: direction, animated: true) {
                [weak self](finish)  in
                self?.currentSelectIndex = index
            }
        }
    }
    
    override func configUI() {
        guard let vcs = vcs else { return }
        addChild(pageVC)
        view.addSubview(pageVC.view)
        
        pageVC.dataSource = self
        pageVC.delegate = self
        pageVC.setViewControllers([vcs[0]], direction: .forward, animated: true, completion: nil)
        
        switch pageStyle {
            
            case .none:
                pageVC.view.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            case .navgationBarSegment:
                segment.backgroundColor = .clear
                segment.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white.withAlphaComponent(0.5),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)]
                segment.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)]
                segment.selectionIndicatorLocation = .none
                //在NavigationBar里添加
                navigationItem.titleView = segment
                segment.frame = CGRect(x: 0, y: 0, width: screenWidth-120, height: 40)
                pageVC.view.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            case .topTabBar:
                //在NavigationBar下添加
                segment.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
                segment.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(r: 127, g: 221, b: 146),
                                                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
                segment.selectionIndicatorLocation = .down
                segment.selectionIndicatorColor = UIColor(r: 127, g: 221, b: 146)
                segment.selectionIndicatorHeight = 2
                segment.borderType = .bottom
                segment.borderColor = UIColor.lightGray
                segment.borderWidth = 0.5
                
                view.addSubview(segment)
                 segment.snp.makeConstraints{
                    $0.top.left.right.equalToSuperview()
                    $0.height.equalTo(40)
                }
                           
                pageVC.view.snp.makeConstraints{
                    $0.top.equalTo(segment.snp.bottom)
                    $0.left.right.bottom.equalToSuperview()
                }
            default:break
        }
        guard let titles = titles else {return}
        segment.sectionTitles = titles
        currentSelectIndex = 0
        segment.selectedSegmentIndex = currentSelectIndex
    }
}


extension UPageViewController:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.firstIndex(of: viewController) else { return nil }
        let before = index - 1
        guard before >= 0  else {return nil}
        return vcs[before]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcs.lastIndex(of: viewController) else { return nil }
        let last = index + 1
        guard last <= vcs.count - 1 else {return nil}
        return vcs[last]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.last,
            let index = vcs.firstIndex(of: viewController)
        else { return  }
        currentSelectIndex = index
        segment.setSelectedSegmentIndex(UInt(currentSelectIndex), animated: true)
        guard titles != nil && pageStyle == UPageStyle.none else { return }
        navigationItem.title = titles[index]
    }
    
}
