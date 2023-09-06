public with sharing class bondOfferingService {
  
  public  String paramterID{get;set;}
   public Integer rec{get;set;}
   public Integer total{get;set;}
  public String selectList {get;set;}
  public String BId{get;set;}
    public List<BondsDetail> bondsDetail{get;set;}
    public List<SelectOption> Investors_Type{get;set;}
    public Integer LimitSize{get;set;}
  public  Integer offNum{get;set;}
    public bondOfferingService(ApexPages.StandardController stdController){
      LimitSize=1;
      offNum=(LimitSize-1)*5;
      paramterID=  ApexPages.currentPage().getParameters().get('Id');
      this.bondsDetail = bondOffering();
      total = (this.bondsDetail.size() + 4) / 5;
      if (total == 0) {
          total = 1;
      }
  
    //  updatePage();
      
        //TestSet=bondOffering().TypeSet;
  //      this.bonds=stdController.addFields(bin)
    }
    
    public class BondsDetail implements Comparable{
        public Boolean isdisable{get;set;}
        public Boolean check{get;set;}
        public Decimal Unit{get;set;}
        public String Status{get;set;}
        public String InvestorsName{get;set;}
        public String Type{get;set;}
        
     
         public BondsDetail(){
          isdisable=false;
           check=false;
            Unit=0;
            Status='';
            InvestorsName='';
            Type='';
           
        }
        // 实现 compareTo 方法来定义比较逻辑
    public Integer compareTo(Object o) {
      BondsDetail other = (BondsDetail)o;
      return this.InvestorsName.compareTo(other.InvestorsName);
  }
    
    }
  
    public List<BondsDetail> sort(List<BondsDetail> bondDetail) {
      List<BondsDetail> sortedList = new List<BondsDetail>(bondDetail);
      sortedList.sort();
      return sortedList;
    }   
    public void updatePage() {
      System.debug('updatePage*');
      //String soql='SELECT Count() FROM Bond_Buy__c  where Bond_Offering__r.Id=:paramterID';
      //String SelectType='Where Investors__r.Type__c= :BIutTesd';
     //Integer bondbuyTest;//=BondDetailsList.size();
     // if(BId==null ||BId=='--Any Type--' ){
     // bondbuyTest=Database.countQuery(soql);
      
   // }
    // else{
     // bondbuyTest=Database.countQuery(Soql+SelectType);
   // }
  //  totalRecs=(Integer)bondbuyTest[0].get('expr0');
 // System.debug(bondbuyTest);
   // total=bondbuyTest/5;
   
    
     System.debug('total'+total);//+'totalRacs'+totalRecs);
 //    System.debug(LimitSize);
   }
   
   public PageReference Firstbtn() {
    LimitSize = 1;
    PageReference pageRef = Page.test; // 替换为您的Visualforce页面名称
    pageRef.getParameters().put('Id', paramterID);
    pageRef.getParameters().put('LimitSize', String.valueOf(LimitSize));
 //   pageRef.setRedirect(true);
    System.debug(LimitSize);
    return pageRef;
//    System.debug(LimitSize);
}

public PageReference prvbtn() {
    if (LimitSize > 1) {
        LimitSize--;
    }
    PageReference pageRef = Page.test; // 替换为您的Visualforce页面名称
    pageRef.getParameters().put('Id', paramterID);
    pageRef.getParameters().put('LimitSize', String.valueOf(LimitSize));
   // pageRef.setRedirect(true);
    System.debug(LimitSize);
    return pageRef;
 //   
}

public PageReference Nxtbtn() {
  if (LimitSize < total) {
      LimitSize++;
  }

  // 计算当前页面的偏移量
   offNum = (LimitSize - 1) * 5;

  // 构建页面跳转链接
  PageReference pageRef = Page.test; // 替换为您的 Visualforce 页面名称
  // pageRef.getParameters().put('Id', paramterID);
  // pageRef.getParameters().put('LimitSize', String.valueOf(LimitSize));
  //pageRef.setRedirect(true);
  pageRef.getParameters().put('LimitSize', String.valueOf(LimitSize));
    pageRef.getParameters().put('Offset', String.valueOf(offNum)); //
  System.debug(LimitSize);
  return pageRef;
}



public PageReference lstbtn() {
    LimitSize = total;
    PageReference pageRef = Page.test; // 替换为您的Visualforce页面名称
    pageRef.getParameters().put('Id', paramterID);
    pageRef.getParameters().put('LimitSize', String.valueOf(LimitSize));
    //pageRef.setRedirect(true);
   
    pageRef.getParameters().put('Offset', String.valueOf(offNum)); // 
    System.debug(LimitSize);
    return pageRef;
  
}

   public Boolean getNxt() {
    if(( LimitSize) > total)
   return true;
 else
   return false;
    
}
 public Boolean getPrv() {
  if(LimitSize<total)
      return true;
    else
      return false;
 

    }

    public List<BondsDetail> bondOffering() { 
      System.debug('Bondoffering*');
        Bond_Offering__c bondOfferingList;
       List<BondsDetail> BondDetailsList=new List<BondsDetail>();
       List<SelectOption> TestType=new List<SelectOption>(); 
       List<Bond_Buy__c> bondbuyList=new List<Bond_Buy__c> ();
       List<Bond_Buy__c> newBondList=new List<Bond_Buy__c>();
       List<Investors__c> InvstorsList=new List<Investors__c>();
       Set<String> TypeSet; 
      // if(selectList==null){
      System.debug(paramterID);
      String Soql='SELECT Name,Units__c ,Bond_Offering__r.Id,Bond_Offering__c,Status__c , Investors__r.Default_Bond_Units__c,Investors__r.id, Investors__r.Name ,Investors__r.Type__c FROM Bond_Buy__c  where Bond_Offering__r.Id=:paramterID';
      String OrderBySoql=' ORDER BY Investors__r.Name';
      String SelectType='Where Investors__r.Type__c= :BId';
      String limitBy=' LIMIT 5';
      String offset=' OFFSET '+offNum;
      System.debug('LimitSize'+LimitSize+'offNum'+offNum);
      String newSoql='SELECT Units__c ,Status__c , Investors__r.id, Investors__r.Default_Bond_Units__c,Investors__r.Name ,Investors__r.Type__c FROM Bond_Buy__c';
      String Invstors='SELECT id, Name ,Type__c,Default_Bond_Units__c FROM Investors__c';
      InvstorsList=Database.query(Invstors);
      newBondList=Database.query(newSoql);
      System.debug('newBondList:'+newBondList);
      if(BId==null ||BId=='--Any Type--' ){
        System.debug(Soql+limitBy+offset);
      bondbuyList=Database.query(Soql+limitBy+offset);

    }
     else{
      
      bondbuyList=Database.query(Soql+SelectType+limitBy+offset);
    }
    System.debug(bondbuyList);
      // }
      // else{
       // bondbuyList=[SELECT Name,Units__c ,Bond_Offering__r.Id,Bond_Offering__c,Status__c , Investors__r.id, Investors__r.Name ,Investors__r.Type__c FROM Bond_Buy__c  where Bond_Offering__r.Id=:paramterID AND Investors__r.Type__c= :selectList];
      // } 
      TypeSet=new Set<String>();
        for(Bond_Buy__c bonds:bondbuyList){
           
            BondsDetail BondDetail=New BondsDetail();
           // BondDetail.Id=bonds.Id;
            BondDetail.InvestorsName=bonds.Investors__r.Name;
            BondDetail.Status=bonds.Status__c;
            BondDetail.Type=bonds.Investors__r.Type__c;
            BondDetail.Unit=bonds.Units__c-bonds.Investors__r.Default_Bond_Units__c;
           
            if(bonds.Status__c!='New'){
              BondDetail.check=true;
            } 
            if(bonds.Status__c=='Passed' ||bonds.Status__c=='Purchased')  {
              BondDetail.isdisable=true;
            }    
           System.debug(BondDetailsList);
           if(bonds.Investors__r.Type__c!=null){
            TypeSet.add(bonds.Investors__r.Type__c);
          }
            BondDetailsList.add(BondDetail);
           
            System.debug(Typeset);
            
        }
        newBondList = Database.query(newSoql);

// 创建一个布尔标志来跟踪是否已经找到了匹配项
Boolean foundMatch = false;

for (Bond_Buy__c newbonds : newBondList) {
    if (!foundMatch) {
        for (Bond_Buy__c testbond : bondbuyList) {
            if (testbond.Investors__r.Name == newbonds.Investors__r.Name) {
                foundMatch = true; // 找到匹配项后将标志设置为 true
                break;
            }
        }
        
        // 如果没有找到匹配项，则将记录添加到 BondDetailsList
        if (!foundMatch) {
          if(newbonds.Investors__r.Name!=null){
            BondsDetail BondDetail = new BondsDetail();
            BondDetail.check=false;
            BondDetail.InvestorsName = newbonds.Investors__r.Name;
            BondDetail.Status = 'New';
            BondDetail.Type = newbonds.Investors__r.Type__c;
            if(newbonds.Investors__r.Type__c!=null){
              TypeSet.add(newbonds.Investors__r.Type__c);
            }
            BondDetail.Unit = newbonds.Units__c-newbonds.Investors__r.Default_Bond_Units__c;
            bondbuyList.add(newbonds);
            BondDetailsList.add(BondDetail);
          }
        }
        
    }
}

System.debug(InvstorsList);
for (Investors__c investor : InvstorsList) {
  Boolean foundInvestor = false;

  for (Bond_Buy__c testbond : bondbuyList) {
      if (testbond.Investors__r.Name == investor.Name) {
        foundInvestor = true;
          break;
      }
  }

  if (!foundInvestor && investor.Name != null) {
      BondsDetail bondDetail = new BondsDetail();
      bondDetail.check = false;
      bondDetail.InvestorsName = investor.Name;
      bondDetail.Status = 'New';
      bondDetail.Type = investor.Type__c;
      if(Investor.Type__c!=null){
        TypeSet.add(investor.Type__c);
      }
      bondDetail.Unit = investor.Default_Bond_Units__c;
      BondDetailsList.add(bondDetail);
  }
}




      
       
        Investors_Type=new List<SelectOption>();
        Investors_Type.add(New SelectOption('--Any Type--','--Any Type--'));
        for(String TypeList:TypeSet){
             
        Investors_Type.add(New SelectOption(TypeList,TypeList));
        }
        System.debug('Investors_Type:'+Investors_Type);
       
        System.debug(BondDetailsList);
      //  BondDetailsList.sort();
 //     bondbuyList.sort;
       
        return sort(BondDetailsList); 
    

    } 


  
  }