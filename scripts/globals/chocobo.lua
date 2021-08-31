-----------------------------------
-- Chocobo functions
-- Info from:
--     http://wiki.ffxiclopedia.org/wiki/Chocobo_Renter
--     http://ffxi.allakhazam.com/wiki/Traveling_in_Vana'diel
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/status")
require("scripts/globals/zone")
-----------------------------------

xi = xi or {}
xi.chocobo = xi.chocobo or {}

--[[
Description:
[1] Level required to rent a chocobo
[2] Base price
[3] Amount added to base price
[4] Amount discounted per time interval
[5] Amount of seconds before price decay
[6] Quest "A Chocobo Riding Game" chance
[7] Shadowreign zone flag
[8] Position player is sent to after event, if applicable
--]]

local chocoboInfo =
{
    [xi.zone.AL_ZAHBI]                = {levelReq = 20, basePrice = 250, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {610, -24, 356, 128, 51}},
    [xi.zone.WAJAOM_WOODLANDS]        = {levelReq = 20, basePrice = 200, addedPrice = 20, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil},
    [xi.zone.SOUTHERN_SAN_DORIA_S]    = {levelReq = 15, basePrice = 150, addedPrice = 20, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = {94, -62, 266, 40, 81}},
    [xi.zone.JUGNER_FOREST_S]         = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = nil},
    [xi.zone.BASTOK_MARKETS_S]        = {levelReq = 15, basePrice = 150, addedPrice = 20, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = {380, 0, 147, 192, 88}},
    [xi.zone.PASHHOW_MARSHLANDS_S]    = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = nil},
    [xi.zone.WINDURST_WATERS_S]       = {levelReq = 15, basePrice = 150, addedPrice = 20, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = {320, -4, -46, 192, 95}},
    [xi.zone.MERIPHATAUD_MOUNTAINS_S] = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = nil},
    [xi.zone.LA_THEINE_PLATEAU]       = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil},
    [xi.zone.KONSCHTAT_HIGHLANDS]     = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil},
    [xi.zone.EASTERN_ALTEPA_DESERT]   = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil},
    [xi.zone.TAHRONGI_CANYON]         = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil},
    [xi.zone.YHOATOR_JUNGLE]          = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil},
    [xi.zone.SOUTHERN_SAN_DORIA]      = {levelReq = 15, basePrice = 100, addedPrice = 20, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = {-126, -62, 274, 101, 100}},
    [xi.zone.BASTOK_MINES]            = {levelReq = 15, basePrice = 100, addedPrice = 20, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = {580, 0, -305, 64, 107}},
    [xi.zone.WINDURST_WOODS]          = {levelReq = 15, basePrice = 100, addedPrice = 20, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = {-122, -4, -520, 0, 116}},
    [xi.zone.UPPER_JEUNO]             = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {486, 8, -160, 128, 105}},
    [xi.zone.LOWER_JEUNO]             = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {340, 24, 608, 112, 110}},
    [xi.zone.PORT_JEUNO]              = {levelReq = 20, basePrice = 200, addedPrice = 25, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {-574, 2, 400, 0, 120}},
    [xi.zone.RABAO]                   = {levelReq = 20, basePrice =  90, addedPrice = 10, decayPrice = 5, decayTime = 60, questChance = 0.00, past = false, pos = {420, 8, 360, 64, 125}},
    [xi.zone.KAZHAM]                  = {levelReq = 20, basePrice =  90, addedPrice = 10, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = {-240, 0, 528, 64, 123}},
    [xi.zone.NORG]                    = {levelReq = 20, basePrice =  90, addedPrice = 10, decayPrice = 5, decayTime = 60, questChance = 0.00, past = false, pos = {-456, 17, -348, 0, 123}},
}

-----------------------------------
-- Local functions
-----------------------------------

local function getPrice(zoneId, info)
    local lastPrice = GetServerVariable("[CHOCOBO][" .. zoneId .. "]price")
    local lastTime  = GetServerVariable("[CHOCOBO][" .. zoneId .. "]time")
    local decay     = math.floor((os.time() - lastTime) / info.decayTime) * info.decayPrice
    local price     = math.max(lastPrice - decay, info.basePrice)

    return price
end

local function updatePrice(zoneId, info, price)
    SetServerVariable("[CHOCOBO][" .. zoneId .. "]price", price + info.addedPrice)
    SetServerVariable("[CHOCOBO][" .. zoneId .. "]time", os.time())
end

-----------------------------------
-- Public functions
-----------------------------------

xi.chocobo.initZone = function(zone)
    local zoneId = zone:getID()
    local info = chocoboInfo[zoneId]

    if info then
        SetServerVariable("[CHOCOBO][" .. zoneId .. "]price", info.basePrice)
        SetServerVariable("[CHOCOBO][" .. zoneId .. "]time", os.time())
    else
        printf("[warning] bad zoneId %i in xi.chocobo.initZone (%s)", zoneId, zone:getName())
    end
end

xi.chocobo.renterOnTrigger = function(player, eventSucceed, eventFail)
    local mLvl   = player:getMainLvl()
    local zoneId = player:getZoneID()
    local info   = chocoboInfo[zoneId]

    if info then
        if player:hasKeyItem(xi.ki.CHOCOBO_LICENSE) and mLvl >= info.levelReq and (player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING) or not info.past) then
            local price = getPrice(zoneId, info)
            player:setLocalVar("[CHOCOBO]price", price)

            local currency = 0
            if info.past then
                currency = player:getCurrency("allied_notes")
            else
                currency = player:getGil()
            end

            local lowLevel = (mLvl < 20) and 1 or 0

            player:startEvent(eventSucceed, price, currency, lowLevel)
        else
            player:startEvent(eventFail)
        end
    else
        printf("[warning] player %s passed bad zoneId %i in xi.chocobo.renterOnTrigger", player:getName(), zoneId)
    end
end

xi.chocobo.renterOnEventFinish = function(player, csid, option, eventSucceed)
    if csid == eventSucceed and option == 0 then
        local mLvl   = player:getMainLvl()
        local zoneId = player:getZoneID()
        local info   = chocoboInfo[zoneId]

        if info then
            local price = player:getLocalVar("[CHOCOBO]price")
            player:setLocalVar("[CHOCOBO]price", 0)

            if price and (info.past and player:getCurrency("allied_notes") >= price) or (not info.past and player:delGil(price)) then
                if info.past then
                    player:delCurrency("allied_notes", price)
                end

                updatePrice(zoneId, info, price)

                local duration = 900
                if mLvl >= 20 then
                    duration = 1800 + (player:getMod(xi.mod.CHOCOBO_RIDING_TIME) * 60)
                end

                player:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, 0, 0, duration, true)

                if info.pos then
                    player:setPos(unpack(info.pos))
                end
            else
                printf("[warning] player %s reached succeed without enough currency in xi.chocobo.renterOnEventFinish", player:getName())
            end
        else
            printf("[warning] player %s passed bad zoneId %i in xi.chocobo.renterOnEventFinish", player:getName(), zoneId)
        end
    end
end
