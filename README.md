Madagascar-Roads
================

How do we optimize agricultural productivity in Madagascar, while minimizing infrastructure (road) costs, to feed the growing population in 2050 under conditions of climate change?

================

How do we feed a population that is growing at near-exponential rates? Under a medium population growth model, the UN predicts that global population will reach 9.6 billion by 2050 – an unprecedented 33% increase in less than 40 years.  8.2 billion will live in developing countries, where most people are subsistence farmers extremely vulnerable to climate change that is making growing patterns less predictable.  Climate change is also reducing the productivity of staple crops like wheat and rice in areas of the world (India, Sub-Saharan Africa) where they are the most critical and increasing their productivity in countries (Canada, Norway) where they are comparatively less profitable.  There’s no surprise that world food prices are spiking to historic levels and causing global political and economic instability – culminating in social unrest on the scale of the Arab Spring. 

This program uses an innovative, data-driven geospatial model to generate recommendations on land and infrastructure that could be strategically developed to support future population growth.

Project Overview

This program integrates 20+ large datasets and applies network optimization algorithms to make strategic recommendations for governments and multinational organizations on how best to feed growing populations –strategically and technically, where to grow crops, which crops to grow, where to build roads to transport food and even where to build new cities between existing urban centers and new resource centers. 

This project innovatively aggregates existing large datasets from different agencies in an unified model that generates strategic recommendations on optimizing for food security, population distribution and infrastructure connectivity and minimizing costs in a more cost-effective and evidence-driven way than that currently employed by many developing countries. The model’s dynamic nature means that it can respond to new data or changing government preferences with regard to land availability or infrastructure investment. It has the potential to be a significant game changer when it comes to large-scale economic, social, food and transportation policy planning at the country level – helping countries account for and avoid food-related riots, dense overpopulation of urban areas and poor roads that leave people and economic value stuck. The target audiences are these developing countries government officials, and their international financial backers (UN, World Bank, IMF) since they will be able to actually upon and fund and execute based upon recommendations generated. For that reason, I’ll work up an interactive, easily understandable data visualization demonstrating the program features and exploring the consequences of one set of recommendations in addition to more standard country- and region-specific briefs for key policymakers. For example, the program might suggest that the government of Madagascar needs to build a new east-west road in the northern part of the country to connect resilient pockets of undeveloped agricultural land to the urban centers in the south.

Developing countries have the most – and cheapest – arable land available globally.  Indeed, many investors and governments of developed countries with little remaining arable land are buying millions of acres in developing countries to ensure the future food security of their populations in what has controversially been called a global ‘land grab.’   

However, multiple studies have argued that Africa has sufficient suitable and available land to go from being a net food importer to being able to feed itself – and even start exporting food – in the next 30+ years if it invests in modern technology, improved infrastructure, better technical education and eases regional barriers to trade to develop its own arable land.  Investment in increasing agricultural production is more effective, dollar for dollar, in reducing poverty than any other type of development program.  

The UN, World Bank and African Development Bank have identified infrastructure as one of the greatest constraints to food security in Africa – especially roads, which “link farmers not only with their input markets but also with their product markets.”  For example, the World Bank estimates that actual production will be 40% of potential production if the land is more than 4 hours away from a city of 100,000 people.  It also means that any crops grown will be extremely expensive to transport and integrate into regional supply chains to bring food to the people. 

However, the challenge is staggering: Sub-Saharan Africa only has 15% paved roads compared to 88% in Europe  and a total road density nearly half of other low-income countries globally.  And even when they exist, roads usually have low connectivity, remain narrow, unpaved and are highly susceptible to seasonal weather damage. Regional road infrastructure improvements that improve agricultural productivity could have a tangible, positive impact on GDP as a whole.  

This program allows countries to tackle the road infrastructure problem strategically. It uses network optimization algorithms – because road networks are analogous to graph networks – to strategically generate recommendations for which road infrastructure improvements and construction countries should implement, and in what order, based on resource availability and population demand.

The critical question then, is how to optimize infrastructure creation – keeping road construction costs down, while linking the most important areas to spur agricultural and broader economic growth? Past efforts at targeting road infrastructure investment include convening regional conferences where multiple state partners identify key regional connections that must be made or strategically targeting roads already in disrepair or high frequency roads that are of low quality.  

Some researchers have begun using GIS to cost investment needs of road construction needed to ensure that at least 50% of the rural population lives within 2 kilometers of an all-season road in a location-specific way.  Countries have also commissioned GIS-based analysis of the suitability of land proximate to Cairo for new urban development, so that the government of Egypt can strategically target population growth to highly suitable areas between large urban centers and new resource centers. 

A lot of raw, geospatial satellite data needed on land suitability, availability, resilience to climate change and infrastructure connectivity and cost is publicly available from the World Bank, UN Food and Agriculture Organization, US Geographic Service, and researchers at McGill, Columbia, etc. But it has never been combined in a complex model that can streamline these massive datasets and apply network optimization algorithms and machine learning to create concrete, evidence-based policy recommendations.

The program starts out by splitting the land into a grid of 10 km x 10km cells – for example, the continent of Africa comes out to roughly 450,000 cells – that are the basis for analysis. The program will start by identify land that is suitable and available for growing crops but also resilient to climate change. And because infrastructure connectivity has a significant impact on agricultural productivity, it will then use network optimization algorithms to minimize infrastructure cost. Finally, it will optimize the land’s probable agricultural productivity and identify which pieces of land the government should develop first and where it should build roads. In order of operation: 

•	Identify whether land is suitable for agriculture (and for which crops);

•	Identify whether suitable land it is available or currently in use;

•	Impute an index for each piece of land that captures relative favorability for development (as a function of suitability and availability);

•	Impute an index of land resilience to climate change that captures relative favorability under different climate change conditions; 

•	Find the optimal path using existing roads from each cell to the nearest city; 

•	If the undeveloped land isn’t connected to the existing road network, find the lowest cost connecting road you can construct by modeling location-specific construction costs based on slope, soil bulk weight, soil type, etc.;

•	Find the optimal aggregate (existing and to be built) path from each piece of land to the nearest city;

•	Impute a development index of infrastructure cost and estimated agricultural productivity for each land cell, and order them in a descending array;

•	‘Activate’ each parcel of land starting from the top of the array, aggregating the total estimated agricultural production (in terms of calories) and total infrastructure costs until you reach the upper bound of the projected number of calories demanded annually by the population of Africa in 2050.

The final product is a list of all the existing roads to be expanded, new roads to be built, available land to be developed and crops to be grown. If implemented using Processing or C# / Visual Basic, the recommendations could also be dynamically visualized on a base map of the entire country or continent.
