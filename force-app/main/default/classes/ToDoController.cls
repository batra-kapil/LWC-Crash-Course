public with sharing class ToDoController {
    @AuraEnabled
    public static string saveToDO(String title, Date dueDate){
        try {
            ToDo__c todo = new ToDo__c();
            todo.Title__c = title;
            todo.Due_Date__c = dueDate;
            insert todo;
            return 'Success';
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<ToDo__c> getToDoList(String taskStatus){
        return [SELECT Id, Title__c, Due_Date__c FROM ToDo__c WHERE Status__c=:taskStatus
                ORDER BY Due_Date__c];
    }

    @AuraEnabled
    public static string updateToDo(Id toDoId){
        try {
            ToDo__c todo = [SELECT Id, Status__c FROM ToDo__c WHERE Id=:toDoId];
            todo.Status__c='Completed';
            update todo;
            return 'Success';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}