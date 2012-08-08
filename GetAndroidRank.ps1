
function global:Get-AndroidRank {

  param ($package, $start)

  get "https://market.android.com/details?id=apps_topselling_free&cat=HEALTH_AND_FITNESS&start=$start&num=25"| 
    Parse-Html "//li[@data-docid]" |  
    select @{Name="app";Expression={$_.SelectNodes("div/div/a/img")[0].Attributes["alt"].Value}}, 
           @{Name="package";Expression={$_.Attributes["data-docid"].Value}}, 
           @{Name="rank";Expression={$_.SelectNodes("div/div/div/div")[0].InnerHtml}} | 
    where {$_.package -eq $package} 

}