## Flutter 动态化方案

>1.序列化

将控件进行序列化,在运行时动态加载序列配置

[控件序列化办法][https://github.com/MEnigma/hot_widget]

    优点:
        1.控件可定制
        2.可以调用native层接口,通过flutter中的channel
        3.动态更新
        4.共享主题
    缺点:
        1.每个控件需要单独做序列化
        2.语言关系,无法动态进行调用方法
        3.不支持自定义类与方法

## 效果
<img src="https://github.com/MEnigma/hot_widget/exampleImg/11577425019_.pic.jpg" width="375" alt="图1">


<img src="https://github.com/MEnigma/hot_widget/exampleImg/21577425135_.pic.jpg" width="375" alt="图2">

    图1内容与图2内容都为加载配置动态生成的(包含跳转)


**以上代表个人观点,对于flutter的动态化方案仍在探索中,欢迎讨论**

