@isTest
private class KnowledgeArticleListControllerTest {

    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * コンストラクタ
     * 値なし
     */
    static testMethod void KnowledgeArticleListControllerTest1() {
        System.runAs(testAdminUser) {
            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            System.assertEquals(cls.maxSize, 0);
            
            Test.stopTest();
        }
    }

    /**
     * コンストラクタ
     * 値あり
     */
    static testMethod void KnowledgeArticleListControllerTest2() {
        System.runAs(testAdminUser) {

            KnowledgeForce__kav kav = createKnowledgeForceKav(true);
            // publish
            KnowledgeForce__kav kavResult = [SELECT KnowledgeArticleId,PublishStatus FROM KnowledgeForce__kav WHERE Id =: kav.Id LIMIT 1];
            System.assertEquals(kavResult.PublishStatus, 'Draft');
            // PublishStatus: Draft → Online
            KbManagement.PublishingService.publishArticle(kavResult.KnowledgeArticleId, true);

            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            System.assertEquals(cls.maxSize, 1);
            
            Test.stopTest();
        }
    }

    /**
     * Returns whether we need to see previous button or not
     */
    static testMethod void getPrevRequiredTest1() {
        System.runAs(testAdminUser) {

            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            cls.currentPage = 1;
            // True
            Boolean result = cls.getPrevRequired();
            System.assertEquals(result, false);
            // False
            cls.currentPage = 2;
            result = cls.getPrevRequired();
            System.assertEquals(result, true);
            
            Test.stopTest();
        }
    }

    /**
     * Returns whether we need to see next button or not
     */
    static testMethod void getNextRequiredTest1() {
        System.runAs(testAdminUser) {

            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            cls.currentPage = 1;
            cls.maxSize = 0;
            // True
            Boolean result = cls.getNextRequired();
            System.assertEquals(result, false);
            // False
            cls.currentPage = 2;
            cls.maxSize = 1000;
            result = cls.getNextRequired();
            System.assertEquals(result, true);
            
            Test.stopTest();
        }
    }

    /**
     * Returns current page number 
     */
    static testMethod void getCurrentPageNumberTest1() {
        System.runAs(testAdminUser) {

            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            cls.currentPage = 10;
            Decimal result = cls.getCurrentPageNumber();
            System.assertEquals(result, cls.currentPage);
            
            Test.stopTest();
        }
    }

    /**
     * next
     */
    static testMethod void nextTest1() {
        System.runAs(testAdminUser) {

            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            cls.currentPage = 10;
            cls.maxSize = 1000;
            cls.next();
            
            Test.stopTest();
        }
    }

    /**
     * previous
     */
    static testMethod void previousTest1() {
        System.runAs(testAdminUser) {

            Test.startTest();
            
            KnowledgeArticleListController cls = new KnowledgeArticleListController();
            cls.currentPage = 10;
            cls.previous();
            
            Test.stopTest();
        }
    }

    /**
     * Knowledgeのデータ作成
     */
    private static KnowledgeForce__kav createKnowledgeForceKav(Boolean isInsert) {
        KnowledgeForce__kav knowledge = new KnowledgeForce__kav(
             UrlName = 'UrlName'
            ,Title = 'Title'
            ,Summary = 'Summary'
            ,Language = 'ja'
        );
        if (isInsert) {
            insert knowledge;
        }
        return knowledge;
    }
}