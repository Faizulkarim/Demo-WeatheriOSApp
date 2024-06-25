//
//  WeatherForcastResponseModel.swift
//  WeatheriOSApp
//
//  Created by Md Faizul karim on 3/3/24.
//

import Foundation

// MARK: - WeatherForcastResponseModel
struct WeatherForcastResponseModel: Codable {
    let timelines: Timelines?
    let location: Location?
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double?
}

// MARK: - Timelines
struct Timelines: Codable {
    let minutely: [Minutely]?
    let hourly: [Hourly]?
    let daily: [Daily]?
}

// MARK: - Daily
struct Daily: Codable {
    let time: String?
    let values: Values?
}

// MARK: - Values
struct Values: Codable {
    let cloudBaseAvg, cloudBaseMax, cloudBaseMin, cloudCeilingAvg: Double?
    let cloudCeilingMax, cloudCeilingMin, cloudCoverAvg: Double?
    let cloudCoverMax,temperature: Double?
    let cloudCoverMin, dewPointAvg, dewPointMax, dewPointMin: Double?
    let evapotranspirationAvg, evapotranspirationMax, evapotranspirationMin, evapotranspirationSum: Double?
    let freezingRainIntensityAvg, freezingRainIntensityMax, freezingRainIntensityMin: Double?
    let humidityAvg, humidityMax, humidityMin: Double?
    let iceAccumulationAvg, iceAccumulationLweAvg, iceAccumulationLweMax, iceAccumulationLweMin: Double?
    let iceAccumulationLweSum, iceAccumulationMax, iceAccumulationMin, iceAccumulationSum: Double?
    let moonriseTime, moonsetTime: String?
    let precipitationProbabilityAvg: Double?
    let precipitationProbabilityMax, precipitationProbabilityMin: Double?
    let pressureSurfaceLevelAvg, pressureSurfaceLevelMax, pressureSurfaceLevelMin, rainAccumulationAvg: Double?
    let rainAccumulationLweAvg, rainAccumulationLweMax: Double?
    let rainAccumulationLweMin: Double?
    let rainAccumulationMax: Double?
    let rainAccumulationMin: Double?
    let rainAccumulationSum, rainIntensityAvg, rainIntensityMax: Double?
    let rainIntensityMin, sleetAccumulationAvg, sleetAccumulationLweAvg, sleetAccumulationLweMax: Double?
    let sleetAccumulationLweMin, sleetAccumulationLweSum, sleetAccumulationMax, sleetAccumulationMin: Double?
    let sleetIntensityAvg, sleetIntensityMax, sleetIntensityMin: Double?
    let snowAccumulationAvg, snowAccumulationLweAvg, snowAccumulationLweMax: Double?
    let snowAccumulationLweMin: Double?
    let snowAccumulationLweSum, snowAccumulationMax: Double?
    let snowAccumulationMin: Double?
    let snowAccumulationSum: Double?
    let snowDepthAvg, snowDepthMax, snowDepthMin, snowDepthSum: Double?
    let snowIntensityAvg, snowIntensityMax: Double?
    let snowIntensityMin: Double?
    let sunriseTime, sunsetTime: String?
    let temperatureApparentAvg, temperatureApparentMax, temperatureApparentMin, temperatureAvg: Double?
    let temperatureMax, temperatureMin: Double?
    let uvHealthConcernAvg, uvHealthConcernMax, uvHealthConcernMin, uvIndexAvg: Double?
    let uvIndexMax, uvIndexMin: Double?
    let visibilityAvg, visibilityMax, visibilityMin: Double?
    let weatherCodeMax, weatherCodeMin: Double?
    let windDirectionAvg, windGustAvg, windGustMax, windGustMin: Double?
    let windSpeedAvg, windSpeedMax, windSpeedMin: Double?
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: String?
    let values: Values?
}

// MARK: - Minutely
struct Minutely: Codable {
    let time: String?
    let values: Values?
}
