﻿<%@ WebHandler Language="C#" Class="_handler" %>

using System;
using System.Web;
using System.Web.Mvc;
using Ivony.Html;
using Ivony.Fluent;
using Ivony.Html.Web;
using Ivony.Web;
using System.Text.RegularExpressions;

public class _handler : IHtmlHandler, IHttpHandler
{


  public void Dispose()
  {

  }

  public bool IsReusable
  {
    get { return false; }
  }

  public void ProcessRequest( HttpContext context )
  {
    throw new HttpException( 404, "不能直接访问" );
  }

  public void ProcessDocument( HttpContextBase context, IHtmlDocument document )
  {
    document.Find( "code" ).ForAll( e =>
    {
      var code = e.InnerText();
      code = ProcessKeywords( code );

      e.ClearNodes();
      e.AddFragment( code );
    } );
  }


  private Regex keywords = new Regex( @"\b(string|int|void|class|public|protected|private)\b" );

  private string ProcessKeywords( string code )
  {
    return keywords.Replace( code, match => "<span class='keyword'>" + match.Value + "</span>" );
  }
}