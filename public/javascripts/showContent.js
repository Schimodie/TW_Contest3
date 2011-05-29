function showContent(apivar)
{
  if(apivar == 'api1')
  {
    document.getElementById('api2').setAttribute('class', 'capi inactive');
    document.getElementById('api1').setAttribute('class', 'capi active');
    document.getElementById('capi2').setAttribute('style', 'display: none');
    document.getElementById('capi1').setAttribute('style', 'display: block');
  }
  if(apivar == 'api2')
  {
    document.getElementById('api1').setAttribute('class', 'capi inactive');
    document.getElementById('api2').setAttribute('class', 'capi active');
    document.getElementById('capi1').setAttribute('style', 'display: none');
    document.getElementById('capi2').setAttribute('style', 'display: block');
  }
  if(apivar == 'XML1')
  {
    document.getElementById('JSON1').setAttribute('class', '');
    document.getElementById('XML1').setAttribute('class', 'active');
    document.getElementById('json1').setAttribute('style', 'display: none');
    document.getElementById('xml1').setAttribute('style', 'display: block');
  }
  if(apivar == 'JSON1')
  {
    document.getElementById('XML1').setAttribute('class', '');
    document.getElementById('JSON1').setAttribute('class', 'active');
    document.getElementById('xml1').setAttribute('style', 'display: none');
    document.getElementById('json1').setAttribute('style', 'display: block');
  }
  if(apivar == 'XML2')
  {
    document.getElementById('JSON2').setAttribute('class', '');
    document.getElementById('XML2').setAttribute('class', 'active');
    document.getElementById('json2').setAttribute('style', 'display: none');
    document.getElementById('xml2').setAttribute('style', 'display: block');
  }
  if(apivar == 'JSON2')
  {
    document.getElementById('XML2').setAttribute('class', '');
    document.getElementById('JSON2').setAttribute('class', 'active');
    document.getElementById('xml2').setAttribute('style', 'display: none');
    document.getElementById('json2').setAttribute('style', 'display: block');
  }
}

