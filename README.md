# Openweathermap::Sdk

#### Bem-vindo ! ####

Esta gem foi criada para a resolucao de um desafio técnico proposto pela Caiena. 

####  *** Não use em produção ***

## Instalação

Instale a gem executando:

    $ git clone https://github.com/evanir/openweathermap-sdk.git
    $ gem build openweathermap-sdk.gemspec

    $ gem install openweathermap-sdk-0.1.1.gem

ou inclua no Gemfile após o git clone.

    gem "openweathermap-sdk", path: "/path/of/local/openweathermap-sdk/"


## Requerimentos

É necessário criar uma conta e obter uma chave no https://home.openweathermap.org/api_keys.

renomeie o arquivo .env_example para .env e informe a chave obtida pelo OpenWeatherMap.

    OPENWEATHERMAP_KEY="SUA CHAVE"

## Uso

Deve ser informado pelo menos um parametro, podendo ser **city_id** ou **city_name**.


    Openweathermap::Sdk::Client.new(city_id: city_id | city_name: city_name)
    
ex:
    
    forecast = Openweathermap::Sdk::Client.new(city_id: 3448639)  # id da cidade de São José do Rio Preto
ou

    forecast = Openweathermap::Sdk::Client.new(city_name: "Campinas")

validando:

    $ forecast.valid?
     => true 

Previsão de tempo do momento atual:

    $ forecast.weather_response
        => {"coord"=>{"lon"=>-49.3794, "lat"=>-20.8197},                                                        
            "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"céu limpo", "icon"=>"01d"}],               
            "base"=>"stations",                                                                                 
            "main"=>{"temp"=>26.15, "feels_like"=>26.15, "temp_min"=>26.15, "temp_max"=>26.15, "pressure"=>1018, "humidity"=>53},
            "visibility"=>10000,                                 
            "wind"=>{"speed"=>4.12, "deg"=>180},                 
            "clouds"=>{"all"=>0},                                
            "dt"=>1664556354,                                    
            "sys"=>{"type"=>1, "id"=>8448, "country"=>"BR", "sunrise"=>1664528375, "sunset"=>1664572519},
            "timezone"=>-10800,                                  
            "id"=>3448639,                                       
            "name"=>"São José do Rio Preto",                     
            "cod"=>200}              

Previsao de tempo para os proximos 5 dias:

    $ forecast.forecast_response
        => {"cod"=>"200",                                        
            "message"=>0,                                        
            "cnt"=>40,                                           
            "list"=> [{"dt"=>1664560800,                                 
                       "main"=> {"temp"=>26.15, "feels_like"=>26.15, "temp_min"=>26.15,
                                 "temp_max"=>29.54, "pressure"=>1018, "sea_level"=>1018,
                                 "grnd_level"=>957, "humidity"=>53, "temp_kf"=>-3.39},
            "weather"=>[{"id"=>500, "main"=>"Rain", "description"=>"chuva leve", "icon"=>"10d"}],
            "clouds"=>{"all"=>0},                             
            "wind"=>{"speed"=>1.93, "deg"=>214, "gust"=>1.99},
            "visibility"=>10000,                              
            "pop"=>0.28,                                      
            "rain"=>{"3h"=>0.14},                             
            "sys"=>{"pod"=>"d"},                              
            "dt_txt"=>"2022-09-30 18:00:00"}, 
            
**...**
            
            {"dt"=>1664982000,
             "main"=>{"temp"=>31.67, "feels_like"=>31.98, "temp_min"=>31.67, "temp_max"=>31.67, "pressure"=>1011, "sea_level"=>1011, "grnd_level"=>955, "humidity"=>41, "temp_kf"=>0},
            "weather"=>[{"id"=>800, "main"=>"Clear", "description"=>"céu limpo", "icon"=>"01d"}],
            "clouds"=>{"all"=>2},
            "wind"=>{"speed"=>2.57, "deg"=>354, "gust"=>2.9},
            "visibility"=>10000,
            "pop"=>0.03,
            "sys"=>{"pod"=>"d"},
            "dt_txt"=>"2022-10-05 15:00:00"}],
            "city"=>
                {"id"=>3448639,
                    "name"=>"São José do Rio Preto",
                    "coord"=>{"lat"=>-20.8197, "lon"=>-49.3794},
                    "country"=>"BR",
                    "population"=>374699,
                    "timezone"=>-10800,
                    "sunrise"=>1664528375,
                    "sunset"=>1664572519}
             } 
   




## Contribuições

Bug reports e pull requests são bemvindos em GitHub at https://github.com/evanir/openweathermap-sdk.

## TODO

