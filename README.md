
 其实搜素界面的轮子很多,但是之所以再写,是因为发现市面上的很多框架,包括高分框架都是替我们制定了几种类型的搜素页面样式, 但是如果我们产品提出了另一种样式的要求,自定义页面很不方面. 基于能更方便的自定义搜索页面的目的, 写下这个轮子.
 
 ![LLSearchViewControllerBase结构说明](http://www.lilongcnc.cc/lauren_picture/20170822/0.gif)
 
### LLSearchViewControllerBase说明
 
 LLSearchViewControllerBase使用的是 `MVP` 模式.尾部有`Presenter`或者`P`的都是对应名称的业务逻辑主持人,可以理解为业务处理者. 把业务逻辑代码从`ViewController`中抽取出来,分配到每个 view模块对应的`Presenter`中.  在实际项目中,MVVM 太过于细化, 需要很多的桥接方法, 我并不是很喜欢, MVC 模式又很容易让新上手的人把`c`写的很臃肿, `MVP`模式是一种很折中的模式.
 
 实现功能  
> - （1）自定义搜索页面View  
> - （2）历史搜索 
> - （3）分类标签 
> - （4）即时搜索结果匹配。
 
 
![LLSearchViewControllerBase结构说明](http://www.lilongcnc.cc/lauren_picture/20170822/1.png)


每个功能模块极其展示 view都尽可能的独立出来. 

### 关于自定义搜索界面

   `ExtensionView`文件夹下边类,是搜索页面的[历史搜索模块,分类模块,即时匹配结果模块]的 view, `ExtensionPresenter`中是历史搜索页面的业务处理者. 而[历史搜索模块,分类模块]的业务处理者我则放到了`SSearchVC`目录下,这样做其实并不是特别好, 我这么做是为了 demo 的展现, 在实际项目中, 其实你可以完全放到`ExtensionPresenter`文件夹下.
   
   ![LLSearchViewControllerBase结构说明](http://www.lilongcnc.cc/lauren_picture/20170822/3.png)

> - 我自定义了处理`历史搜索记录-LLNaviSearchHistorySaveBasePresenter`的基类和`搜索控制器-LLNaviSearchBaseVC`页面的基类,子类只需要继承这两个类就可以.
> - `分类模块`和`即时匹配`模块没有基类,也不需要, 你如果不想要这两个功能,直接不实现其方法或者删掉相关代码即可.
> - `LLSearchNaviBarView`是一个带有搜索框的模拟导航栏,你在任何地方都可以用它.


其中:
1. 历史搜索基类有保存,清理,获取保存记录方法. 子类继承之后,需要在实现下面代码(注意:指明存储文件名字)
 
    - (instancetype)init{
        if (self = [super init]) {
            //code...
            self.saveUtils = [[LLSearchHistorySaveUtils alloc] initWithSearchHistoriesCacheFileName:NearByShopSearchMapAddressHistoryCacheFileName];
            
        }
        return self;
    }


2. 控制器 ViewController需要在继承之后, 指定各模块的业务处理者是谁
            
        -(void)viewDidLoad {    
          //告诉父类你的历史搜索prestenter是什么
          self.shopHistoryP = [HistoryAndCategorySearchHistroyViewP new];
          //告诉父类你的分类prestenter是什么
          self.shopCategoryP = [HistoryAndCategorySearchCategoryViewP new];
          [super viewDidLoad];
        }



其他

### 进一步说明

`历史搜索`和`分类`模块都是页面动态或者提前加载的, 为了显示动态还在的过程,我在`HistoryAndCategorySearchVC`这个搜索控制器调用的时候, 特意模拟网络数据延迟3s, 在实际操作中,为了保证体验,建议提前加载保存到本地最好, 我这里并没有针对分类提供本地持久化的方法.

`即时结果匹配`这个功能, 只要实现下边这三个方法,即默认开启.

    /**
     即时搜索匹配框,匹配的数据列表
     */
    @property (nonatomic,strong) NSArray<NSString *> *resultListArray;
    /**
     搜索框:用户即时输入完毕
     @param didChangeBlock 更改后的回调
     */
    - (void)searchbarDidChange:(searchBarDidChangeBlock)didChangeBlock;
    
    /**
     即时匹配结果列表cell点击事件
     */
    - (void)resultListViewDidSelectedIndex:(resultListViewCellDidClickBlock)cellDidClickBlock;


最后, 下面几个控制器调用的地方,提供了部分搜索页面接口展示:
![LLSearchViewControllerBase结构说明](http://www.lilongcnc.cc/lauren_picture/20170822/4.png)

