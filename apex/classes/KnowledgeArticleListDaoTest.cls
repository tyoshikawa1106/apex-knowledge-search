@isTest
private class KnowledgeArticleListDaoTest {

    private static KnowledgeArticleListDao dao = new KnowledgeArticleListDao();
    private static User testAdminUser = new User(Id = UserInfo.getUserId());

    /**
     * 記事情報取得
     * 値なし
     */
    static testMethod void getKnowledgeArticleVersionListTest1() {
        System.runAs(testAdminUser) {
            Test.startTest();
            
            List<KnowledgeArticleVersion> results = dao.getKnowledgeArticleVersionList();
            System.assertEquals(results.isEmpty(), true);
            
            Test.stopTest();
        }
    }

    /**
     * 記事情報取得
     * 値あり
     */
    static testMethod void getKnowledgeArticleVersionListTest2() {
        System.runAs(testAdminUser) {
            KnowledgeForce__kav kav = createKnowledgeForceKav(true);
            // publish
            KnowledgeForce__kav kavResult = [SELECT KnowledgeArticleId,PublishStatus FROM KnowledgeForce__kav WHERE Id =: kav.Id LIMIT 1];
            System.assertEquals(kavResult.PublishStatus, 'Draft');
            // PublishStatus: Draft → Online
            KbManagement.PublishingService.publishArticle(kavResult.KnowledgeArticleId, true);

            Test.startTest();
            
            List<KnowledgeArticleVersion> results = dao.getKnowledgeArticleVersionList();
            System.assertEquals(results.size(), 1);
            
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