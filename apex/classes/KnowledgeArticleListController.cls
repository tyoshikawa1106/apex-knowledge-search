public with sharing class KnowledgeArticleListController {

    private KnowledgeArticleListDao dao = new KnowledgeArticleListDao();
    // Page Size
    private Static Final Integer PAGE_NUMBER = 10;
    // Search String used in ArticleList tag
    public String searchstring { get; set; }
    @TestVisible
    // Keeps track of current page & max size of article list
    private Integer currentPage = 1; 
    @TestVisible
    private Integer maxSize = 1;

    /**
     * コンストラクタ
     */
    public KnowledgeArticleListController() {
        // 記事情報取得
        List<KnowledgeArticleVersion> articleList = this.dao.getKnowledgeArticleVersionList();
        // Max Size取得
        this.maxSize = articleList.size();
        // Search Key
        this.searchstring = '';
    }

    /**
     * Returns whether we need to see previous button or not
     */
    public Boolean getPrevRequired() {
        return this.currentPage > 1;
    }

    /**
     * Returns whether we need to see next button or not
     */
    public Boolean getNextRequired() {
        return this.currentPage * PAGE_NUMBER < this.maxSize;
    }

    /**
     * Returns current page number 
     */
    public Decimal getCurrentPageNumber() {
        return this.currentPage;
    }

    /**
     * action for next click
     */
    public void next() {
        if(this.maxSize > this.currentPage * PAGE_NUMBER) {
            this.currentPage = this.currentPage + 1;
        }
    }
 
    /**
     * action for previous click
     */
    public void previous() {        
        if(this.currentPage > 1) {
            this.currentPage = this.currentPage - 1;
        }
    }
}