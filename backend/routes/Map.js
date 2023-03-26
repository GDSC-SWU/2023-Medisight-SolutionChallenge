const express = require('express');
const request = require("request");
const router = express.Router();


router.get('/place', async (req, res) => {
    const keyword = req.query.keyword;
    const lat = req.query.lat;
    const lng = req.query.lng;
    const apiKey = process.env.TMAP_APPKEY;
    const endpoint = 'https://apis.openapi.sk.com/tmap/pois?version=1&searchKeyword=%EC%95%BD%EA%B5%AD&searchType=all&searchtypCd=R&centerLon=' + lng + '&centerLat=' + lat + '&reqCoordType=WGS84GEO&resCoordType=WGS84GEO&radius=5&page=1&count=20&multiPoint=N&poiGroupYn=N';

    request.get({
        headers: {'Accept' : 'application/json', 'appKey' : apiKey},
        url: endpoint
    },
    function(error, response, body){
        const json = JSON.parse(body)
        const result = cleanse_place(json.searchPoiInfo.pois.poi)
        //console.log(result);
        res.send({result});
    });
});

function cleanse_place(poiList) {
    let result = []
    poiList.forEach((poi) => {
        const cleansedPoi = {}
        if (poi.name.includes('약국') && !poi.name.includes('주차장')) {
            cleansedPoi.endPoiId = poi.id
            cleansedPoi.name = poi.name
            cleansedPoi.telNo = poi.telNo
            cleansedPoi.noorLat = poi.noorLat
            cleansedPoi.noorLon = poi.noorLon
            cleansedPoi.address = poi.newAddressList.newAddress[0].fullAddressRoad
            result.push(cleansedPoi)
        }
    });
    return result
}

router.post('/route', async (req, res) => {
    const lat = req.query.lat;
    const lng = req.query.lng;
    const destLat = req.query.destLat;
    const destLng = req.query.destLng;

    const apiKey = process.env.TMAP_APPKEY;
    const endpoint = 'https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&callback=function';
    const payload = {
        "startX": parseFloat(lng), // 내위치
        "startY": parseFloat(lat),
        "speed": 30,
        "endPoiId": "10866029",
        "endX": parseFloat(destLng), // 목적지
        "endY": parseFloat(destLat),
        "reqCoordType": "WGS84GEO",
        "startName": "%EC%B6%9C%EB%B0%9C",
        "endName": "%EB%8F%84%EC%B0%A9",
        "searchOption": "0",
        "resCoordType": "WGS84GEO",
        "sort": "index"
      }

    request.post({
        headers: {'Accept' : 'application/json', 'appKey' : apiKey},
        url: endpoint,
        body: JSON.stringify(payload)
    },
    function(error, response, body){
        const json = JSON.parse(body)
        const result = cleanse_route(json.features)
        //console.log(result);
        res.send(result);
    });
});

// 경로 안내 화면에 띄울 정보 반환
// 근처 2개의 데이터 반환
function cleanse_route(featureList) {
    let result = {}
    const firstProp = featureList[0].properties // point
    const secondProp = featureList[1].properties // linestring
    const thirdProp = featureList[2].properties // point
    const fourthProp = featureList[3].properties // linestring
    const fifthProp = featureList[4].properties // point

    result.totalDistance = firstProp.totalDistance
    result.totalTime = firstProp.totalTime
    
    result.inst_now = {
        remain: 0,
        description: firstProp.description,
        turnType: firstProp.turnType
    }

    result.inst_next = {
        remain: secondProp.distance,
        description: thirdProp.description,
        turnType: thirdProp.turnType
    }

    result.inst_next_next = {
        remain: secondProp.distance + fourthProp.distance,
        description: fifthProp.description,
        turnType: fifthProp.turnType
    }

    return result
}

router.post('/route/coords', async (req, res) => {
    const lat = req.query.lat;
    const lng = req.query.lng;
    const destLat = req.query.destLat;
    const destLng = req.query.destLng;
    
    const apiKey = process.env.TMAP_APPKEY;
    const endpoint = 'https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1&callback=function';
    const payload = {
        "startX": parseFloat(lng), // 내위치
        "startY": parseFloat(lat),
        "speed": 30,
        "endPoiId": "10866029",
        "endX": parseFloat(destLng), // 목적지
        "endY": parseFloat(destLat),
        "reqCoordType": "WGS84GEO",
        "startName": "%EC%B6%9C%EB%B0%9C",
        "endName": "%EB%8F%84%EC%B0%A9",
        "searchOption": "0",
        "resCoordType": "WGS84GEO",
        "sort": "index"
    }

    request.post({
        headers: {'Accept' : 'application/json', 'appKey' : apiKey},
        url: endpoint,
        body: JSON.stringify(payload)
    },
    function(error, response, body){
        const json = JSON.parse(body)
        const result = {}
        result.points = get_route_points(json.features)
        result.linestrings = get_route_lines(json.features)
        //console.log(result);
        res.send(result);
    });
});

// 지도에 그릴 포인트 좌표 반환
// 모든 데이터 반환
function get_route_points(featureList) {
    let result = []

    featureList.forEach((feature) => {
        if (feature.geometry.type == 'Point'){
            let coord = {
                lat: feature.geometry.coordinates[1],
                lng: feature.geometry.coordinates[0],
            }
            result.push(coord);
        }
    });
    return result
}

// 지도에 그릴 라인 좌표 반환
// 모든 데이터 반환
function get_route_lines(featureList) {
    let result = []

    featureList.forEach((feature) => {
        if (feature.geometry.type == 'LineString'){
            let cleansed = []
            feature.geometry.coordinates.forEach((e) => cleansed.push({lat: e[1], lng: e[0]}))
            let coord = {
                path: cleansed
            }
            result.push(coord);
        }
    });
    return result
}

module.exports = router;