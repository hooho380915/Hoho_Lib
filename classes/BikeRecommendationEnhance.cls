global class BikeRecommendationEnhance {
    @InvocableMethod(label='Apply bike discounts for members'
                     description='This function is meant to be used in an Enhance node in Einstein Next Best Action')
    global static List<List<Recommendation>> applyDiscounts(List<BikeRecommendationEnhanceRequest> inputRequests) {
        List<List<Recommendation>> outputs = new List<List<Recommendation>>();
        
        for (BikeRecommendationEnhanceRequest inputRequest : inputRequests)
        {
            List<Recommendation> singleRequestOutputs = new List<Recommendation>();
            
            for (Recommendation inputRecommendation : inputRequest.recommendations)
            {
				if (inputRequest.isVelostarsMember)
                {
                    //Apply a 10% discount for members
                    inputRecommendation.Price__c = inputRecommendation.Price__c * 0.9;
                    
                }
                
                Integer price = inputRecommendation.Price__c.intValue();
                
                //Adjust the description to include the price
                inputRecommendation.Description = inputRecommendation.Description + ' $' + price;
                
                singleRequestOutputs.add(inputRecommendation);
            }      
            outputs.add(singleRequestOutputs);
        }
        return outputs;
    }
    
    global class BikeRecommendationEnhanceRequest {
        @InvocableVariable(label='Is VeloStars Member?')
        global Boolean isVelostarsMember;
        
        @InvocableVariable
        global List<Recommendation> recommendations;
    }
}