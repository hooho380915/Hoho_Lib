global class BikeRecommendationGenerator {
    @InvocableMethod(
        label='Bike Recommendation Generator'
        description='This function returns recommendations for the bikes in our catalog.')
     global static List<List<Recommendation>> getBikes(List<BikeRecommendationGenerateRequest> inputRequests){
        List<List<Recommendation>> outputs = new List<List<Recommendation>>();
        
        for (BikeRecommendationGenerateRequest inputRequest : inputRequests)
        {
            Contact currentContact = [SELECT Bike_Type_Interest__c FROM Contact WHERE Id=:inputRequest.contactId];
            List<Product2> products;
            
            if (currentContact!=null && currentContact.Bike_Type_Interest__c!='') 
            {
                //If we know the type of bike this customer likes, let's recommend one of those
                products = [SELECT Name, Description,Price__c FROM Product2 WHERE Family=:currentContact.Bike_Type_Interest__c];
            } else {
                //Otherwise grab all the bikes we have in stock
            	products = [SELECT Name, Description,Price__c FROM Product2];
            }
            
            List<Recommendation> recs = new List<Recommendation>(); 
            for (Product2 prod:products) {
                Recommendation rec = new Recommendation(
                    Name = prod.Name,
                    Description = prod.Description,
                    Price__c = prod.Price__c,                      
                    ActionReference = 'Purchase_A_Bike',
                    AcceptanceLabel = 'Buy'
                );
                recs.add(rec);
            }
            outputs.add(recs);
        }
        return outputs; 
    }
    
    global class BikeRecommendationGenerateRequest {
        @InvocableVariable(label='Contact ID')
        global String contactId;
    }
}