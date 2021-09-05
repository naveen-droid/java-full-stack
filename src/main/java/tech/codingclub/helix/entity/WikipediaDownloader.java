package tech.codingclub.helix.entity;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import tech.codingclub.helix.global.HTTPUrlConnectionExample;

public class WikipediaDownloader{

    private String keyword;

    public WikipediaDownloader(){

    }
    public WikipediaDownloader(String keyword){
        this.keyword=keyword;
    }
    public WikiResult getResult() {
        //1.get clean Keyword
        //2.get the url for wikipedia
        //3.make a GET request to wikipedia
        //4.parsing the useful result using jsoup
        //5.showing result to user
        if (this.keyword == null || this.keyword.length() == 0) {
            return null;
        }
        //Step 1
        this.keyword = this.keyword.trim().replaceAll("[ ]+", "_");

        //Step 2
        String wikiUrl = getWikipediaUrlForQuery(this.keyword);
        String response = "";
        String imageUrl = null;
        try {
            //Step3
            String wikipediaResponseHtml = HTTPUrlConnectionExample.sendGet(wikiUrl);
            //System.out.println(wikipediaResponseHtml);
            //Step 4
            Document document = Jsoup.parse(wikipediaResponseHtml, "https://en.wikipedia.org");

            Elements childElements = document.body().select(".mw-parser-output > *");
            int state = 0;

            for (Element childElement : childElements) {
                if (state == 0) {
                    if (childElement.tagName().equals("table")) {
                        state = 1;
                    }
                } else if (state == 1) {
                    if (childElement.tagName().equals("p")) {
                        state = 2;
                        response = childElement.text();
                        break;
                    }
                }
            }
            try {
                imageUrl=document.body().select(".infobox img").get(0).attr("src");
            }catch(Exception ex){

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        WikiResult wikiResult = new WikiResult(this.keyword, response, imageUrl);
        //Push result into database

           // WikiResult wikiResult=new WikiResult(this.keyword,response,imageUrl);
            //Push result into database
           return wikiResult;

    }


    private String getWikipediaUrlForQuery(String cleanKeyword) {
        return "https://en.wikipedia.org/wiki/"+cleanKeyword;

    }
}
