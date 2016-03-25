public with sharing class KnowledgeArticleListDao {

    /**
     * コンストラクタ
     */
    public KnowledgeArticleListDao() {
        
    }

    /**
     * 記事情報取得
     */
    public List<KnowledgeArticleVersion> getKnowledgeArticleVersionList() {
        return [
            SELECT
                 Id
                ,Title
            FROM
                KnowledgeArticleVersion
            WHERE
                PublishStatus = 'online'
            AND
                Language = 'ja'
            ORDER BY Title ASC
            LIMIT 500
        ];
    }
}