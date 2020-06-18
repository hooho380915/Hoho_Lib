/** ************************************
* Author     :   Alex Chen        
* Description:   Lib_Chatter : 
* Test Class :   Lib_Chatter_Test
* Function List:
        

* History
* <Date>        <Authors Name> 	<Brief Description of Change>
* 20200318        Alex Chen       Create
* 20200618      Alex Chen           Modify
* 流程改善- Git Study -V2 => LIB_Chatter-Date-DB
************************************** */
public without sharing class Lib_Chatter {

    ////////////////////////////////////////////////////////////
    /**
    *
    */
    public class mention_info
    {
        public mention_info(String tmpSegmentText,String tmpMention_User_Id,String tmpSubjectId)
        {
            this.sSegmentText           = tmpSegmentText;
            this.sMention_User_Id       = tmpMention_User_Id;
            this.sSubjectId             = tmpSubjectId;
        }
        public String sSegmentText{get;set;}
        public String sMention_User_Id{get;set;}
        public String sSubjectId{get;set;}
        //If feedType is Record, sSubjectId can be any record ID, including a group ID.
        //If feedType is Topics, sSubjectId must be a topic ID.
        //If feedType is UserProfile, sSubjectId can be any user ID.
        //If the feedType is any other value, sSubjectId must be the ID of the context user or the keyword me.
    }

    /**
    *
    */
    public static  void Chatter_Feeds(String tmpSegmentText,String tmpMention_User_Id,String tmpRecordId)
    {
        mention_info mention=new mention_info(tmpSegmentText,tmpMention_User_Id, tmpRecordId);
        Chatter_Feeds(mention);
    }
    public static  void Chatter_Feeds(mention_info mention)
    {

        ConnectApi.MessageBodyInput     messageInput= new ConnectApi.MessageBodyInput();
        messageInput.messageSegments                = new List<ConnectApi.MessageSegmentInput>();
        ConnectApi.TextSegmentInput     textSegment = new ConnectApi.TextSegmentInput();
        ConnectApi.FeedType             feedType    = ConnectApi.FeedType.Record;
        ConnectApi.FeedItemInput        input       = new ConnectApi.FeedItemInput();
        ConnectApi.MentionSegmentInput  mentionSegment;

        //
        System.debug('指定chatter發送對象');
        mentionSegment      = new ConnectApi.MentionSegmentInput();
        mentionSegment.id   = mention.sMention_User_Id  ;
        messageInput.messageSegments.add(mentionSegment);
        //
        System.debug('指定chatter發送內容');
        textSegment = new ConnectApi.TextSegmentInput();
        textSegment.text = mention.sSegmentText;
        messageInput.messageSegments.add(textSegment);

        input.body = messageInput;
        system.debug('debug@mention.sSubjectId:'+mention.sSubjectId);
        system.debug('##feedType##:'+feedType);
        system.debug('##input##'+input);
        //ConnectApi.FeedItem feedItemRep = ConnectApi.ChatterFeeds.postFeedItem(null, feedType, mention.sSubjectId, input, null);
    }
    public static  void Chatter_Feeds(map<string,mention_info> mention_M)
    {
        for(String KeyValue : mention_M.keySet()){
            mention_info mention=mention_M.get(KeyValue);
            Chatter_Feeds(mention);
        }
    }
    public static  void Chatter_Feeds(List<ConnectApi.BatchInput> BatchInput_L){
        
    }

}