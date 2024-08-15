function fn() {
  var env = karate.env;     // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  if (!env) {
    env = 'dev';    // a custom 'intelligent' default
  }

  var config = {    // global config JSON
    env: env,
  }

  if (env == 'dev') {
    config.userBaseURL = 'https://reqres.in/dev';
    config.TestData = 'testData/DEV';
  }
  else if (env == 'qa') {
    ;
    config.userBaseURL = 'https://reqres.in/';
    config.TestData = 'testData/QA';
  }

  return config;
}
