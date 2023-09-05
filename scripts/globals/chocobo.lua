-----------------------------------
-- Chocobo functions
-- Info from:
--     http://wiki.ffxiclopedia.org/wiki/Chocobo_Renter
--     http://ffxi.allakhazam.com/wiki/Traveling_in_Vana'diel
-----------------------------------
require("scripts/globals/missions")
require("scripts/globals/zone")
require('scripts/globals/npc_util')
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

xi.chocobo.zoneInfo =
{
    [xi.zone.SOUTHERN_SAN_DORIA]      = { levelReq = 15, basePrice = 100, addedPrice = 15, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = { -126, -62,  274, 101, xi.zone.WEST_RONFAURE         } },
    [xi.zone.WINDURST_WOODS]          = { levelReq = 15, basePrice = 100, addedPrice = 15, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = { -122,  -4, -520,   0, xi.zone.EAST_SARUTABARUTA     } },
    [xi.zone.BASTOK_MINES]            = { levelReq = 15, basePrice = 100, addedPrice = 15, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = {  580,   0, -305,  64, xi.zone.SOUTH_GUSTABERG       } },
    [xi.zone.UPPER_JEUNO]             = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {  486,   8, -160, 128, xi.zone.BATALLIA_DOWNS        } },
    [xi.zone.LOWER_JEUNO]             = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {  340,  24,  608, 112, xi.zone.ROLANBERRY_FIELDS     } },
    [xi.zone.PORT_JEUNO]              = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = { -574,   2,  400,   0, xi.zone.SAUROMUGUE_CHAMPAIGN  } },

    [xi.zone.RABAO]                   = { levelReq = 20, basePrice =  90, addedPrice = 10, decayPrice = 5, decayTime = 60, questChance = 0.00, past = false, pos = {  420,   8,  360,  64, xi.zone.WESTERN_ALTEPA_DESERT } },
    [xi.zone.KAZHAM]                  = { levelReq = 20, basePrice =  90, addedPrice = 10, decayPrice = 5, decayTime = 60, questChance = 0.10, past = false, pos = { -240,   0,  528,  64, xi.zone.YUHTUNGA_JUNGLE       } },
    [xi.zone.NORG]                    = { levelReq = 20, basePrice =  90, addedPrice = 10, decayPrice = 5, decayTime = 60, questChance = 0.00, past = false, pos = { -456,  17, -348,   0, xi.zone.YUHTUNGA_JUNGLE       } },

    [xi.zone.YHOATOR_JUNGLE]          = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil                                                     },
    [xi.zone.EASTERN_ALTEPA_DESERT]   = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil                                                     },

    [xi.zone.LA_THEINE_PLATEAU]       = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil                                                     },
    [xi.zone.TAHRONGI_CANYON]         = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil                                                     },
    [xi.zone.KONSCHTAT_HIGHLANDS]     = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil                                                     },

    [xi.zone.AL_ZAHBI]                = { levelReq = 20, basePrice = 250, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = {  610, -24,  356, 128,  xi.zone.WAJAOM_WOODLANDS     } },
    [xi.zone.WAJAOM_WOODLANDS]        = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = false, pos = nil                                                     },

    [xi.zone.SOUTHERN_SAN_DORIA_S]    = { levelReq = 15, basePrice = 150, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = {   94, -62,  266,  40,  xi.zone.EAST_RONFAURE_S      } },
    [xi.zone.WINDURST_WATERS_S]       = { levelReq = 15, basePrice = 150, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = {  320,  -4,  -46, 192,  xi.zone.WEST_SARUTABARUTA_S  } },
    [xi.zone.BASTOK_MARKETS_S]        = { levelReq = 15, basePrice = 150, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = {  380,   0,  147, 192,  xi.zone.NORTH_GUSTABERG_S    } },

    [xi.zone.JUGNER_FOREST_S]         = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = nil                                                     },
    [xi.zone.PASHHOW_MARSHLANDS_S]    = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = nil                                                     },
    [xi.zone.MERIPHATAUD_MOUNTAINS_S] = { levelReq = 20, basePrice = 200, addedPrice = 15, decayPrice = 5, decayTime = 90, questChance = 0.00, past = true , pos = nil                                                     },
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

local function clearPlayerVars(player)
    player:setCharVar("[CHOCOBO]paid", 0)
    player:setCharVar("[CHOCOBO]past", 0)
    player:setCharVar("[CHOCOBO]price", 0)
    player:setCharVar("[CHOCOBO]zone", 0)
    player:setCharVar("Chocopass", 0)
    player:setCharVar("ChocopassDuration", 0)
    player:setCharVar("[CHOCOBO]X", 0)
    player:setCharVar("[CHOCOBO]Y", 0)
    player:setCharVar("[CHOCOBO]Z", 0)
end

-----------------------------------
-- Public functions
-----------------------------------

xi.chocobo.initZone = function(zone)
    local zoneId = zone:getID()
    local info = xi.chocobo.zoneInfo[zoneId]

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
    local info   = xi.chocobo.zoneInfo[zoneId]

    if info then
        if
            player:hasKeyItem(xi.ki.CHOCOBO_LICENSE) and
            mLvl >= info.levelReq and
            (player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.BACK_TO_THE_BEGINNING) or not info.past)
        then
            local price = math.min(getPrice(zoneId, info), 1000)
            player:setCharVar("[CHOCOBO]price", price)
            player:setCharVar("[CHOCOBO]zone", zoneId)

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

xi.chocobo.renterOnTrade = function(player, npc, trade, eventSucceed, eventFail)
    local zoneId = player:getZoneID()
    local info   = xi.chocobo.zoneInfo[zoneId]

    if
        npcUtil.tradeHasExactly(trade, xi.items.FREE_CHOCOPASS) and
        (zoneId == xi.zone.WINDURST_WOODS or zoneId == xi.zone.BASTOK_MINES or zoneId == xi.zone.SOUTHERN_SAN_DORIA)
    then -- Chocopass Fails for Non-Starter Cities
        if info.past then -- Fails for Past Zones
            player:startEvent(eventFail)
        else
            local currency = player:getGil()
            local price = 0

            player:tradeComplete()
            player:setCharVar("Chocopass", 1)
            player:setCharVar("ChocopassDuration", 120)

            player:startEvent(eventSucceed, price, currency)
        end
    elseif
        npcUtil.tradeHasExactly(trade, xi.items.CHOCOBO_TICKET)
    then -- Chocobo Ticket
        if info.past then -- Fails for Past Zones
            player:startEvent(eventFail)
        else
            local mLvl     = player:getMainLvl()
            local currency = player:getGil()
            local price    = 0
            local duration = 1800 + (player:getMod(xi.mod.CHOCOBO_RIDING_TIME) * 60)

            if mLvl >= 20 and player:hasKeyItem(xi.ki.CHOCOBO_LICENSE) then
                player:tradeComplete()
                player:setCharVar("Chocopass", 1)
                player:setCharVar("ChocopassDuration", duration)

                player:startEvent(eventSucceed, price, currency)
            else
                player:startEvent(eventFail) -- Fail Closed
            end
        end
    else
        player:startEvent(eventFail) -- Fail Closed
    end
end

xi.chocobo.renterOnEventFinish = function(player, csid, option, eventSucceed)
    if csid == eventSucceed and option == 0 then
        local mLvl   = player:getMainLvl()
        local zoneId = player:getCharVar("[CHOCOBO]zone")
        local info   = xi.chocobo.zoneInfo[zoneId]
        local trade  = player:getCharVar("Chocopass")

        if info then
            if info.pos then
                -- Store player coords in case of issue
                player:setCharVar("[CHOCOBO]X", player:getXPos())
                player:setCharVar("[CHOCOBO]Y", player:getYPos())
                player:setCharVar("[CHOCOBO]Z", player:getZPos())
            end

            if trade == 1 then
                local duration = player:getCharVar("ChocopassDuration")

                player:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, 0, 0, duration, true)

                if info.pos then
                    player:setPos(unpack(info.pos))
                end

            elseif trade ~= 1 then
                local price = player:getCharVar("[CHOCOBO]price")

                if
                    price and
                    (info.past and player:getCurrency("allied_notes") >= price) or
                    (not info.past and player:delGil(price))
                then
                    if info.past then
                        player:setCharVar("[CHOCOBO]past", 1)
                        player:delCurrency("allied_notes", price)
                    end

                    player:setCharVar("[CHOCOBO]paid", 1)

                    updatePrice(zoneId, info, price)

                    local duration = 900
                    if mLvl >= 20 then
                        duration = 1800 + (player:getMod(xi.mod.CHOCOBO_RIDING_TIME) * 60)
                    end

                    player:addStatusEffectEx(xi.effect.MOUNTED, xi.effect.MOUNTED, 0, 0, duration, true)

                    if info.pos then
                        player:setPos(unpack(info.pos))
                    else
                        player:setCharVar("[CHOCOBO]price", 0)
                        player:setCharVar("[CHOCOBO]zone", 0)
                    end
                else
                    printf("[warning] player %s reached succeed without enough currency in xi.chocobo.renterOnEventFinish", player:getName())
                end
            else
                printf("[warning] player %s passed bad zoneId %i in xi.chocobo.renterOnEventFinish", player:getName(), zoneId)
            end
        end
    end
end

xi.chocobo.confirmRentalOnZone = function(player)
    local currentZoneID = player:getZoneID()
    local chocoboStartingZoneID = player:getCharVar("[CHOCOBO]zone")

    -- If there's no chocobo zoning variable set, then exit the function
    if not chocoboStartingZoneID then
        return
    end

    local info = xi.chocobo.zoneInfo[chocoboStartingZoneID]

    if
        info and
        info.pos and -- for zones that have a nil pos table, this is irrelevant
        chocoboStartingZoneID == currentZoneID
    then
        -- Player was not zoned into the new zone correctly and dumped back to starting zone
        -- Get previous coordinates, price, and past zone status
        local xpos = player:getCharVar("[CHOCOBO]X")
        local ypos = player:getCharVar("[CHOCOBO]Y")
        local zpos = player:getCharVar("[CHOCOBO]Z")

        -- Reset their previous position
        player:setPos(xpos, ypos, zpos, 0)

        -- Remove mounted status
        player:delStatusEffect(xi.effect.MOUNTED)

        -- This messaging must happen after zoning in and is called by the rental zones
        -- to the xi.chocobo.confirmRentalAfterZoneIn function below
    else
        -- Everything is good -- Clear the unused variables
        clearPlayerVars(player)
    end

    player:setCharVar("[CHOCOBO]X", 0)
    player:setCharVar("[CHOCOBO]Y", 0)
    player:setCharVar("[CHOCOBO]Z", 0)
    player:setCharVar("[CHOCOBO]zone", 0)
    player:setCharVar("ChocopassDuration", 0)
end

xi.chocobo.confirmRentalAfterZoneIn = function(player)
    local past      = player:getCharVar("[CHOCOBO]past")
    local cost      = player:getCharVar("[CHOCOBO]price")
    local paid      = player:getCharVar("[CHOCOBO]paid")
    local chocoPass = player:getCharVar("Chocopass")

    if not paid then
        return
    elseif chocoPass == 1 then
        npcUtil.giveItem(player, xi.items.FREE_CHOCOPASS)
        player:PrintToPlayer(string.format("Error while zoning. Your position has been reset and ChocoPass refunded.", cost), xi.msg.channel.SYSTEM_3)
    elseif past == 1 and paid == 1 then
        npcUtil.giveCurrency(player, "allied_notes", cost or 0)
        player:PrintToPlayer(string.format("Error while zoning. Your position has been reset and %s Allied Notes refunded.", cost), xi.msg.channel.SYSTEM_3)
    elseif cost > 0 and paid == 1 then
        npcUtil.giveCurrency(player, "gil", cost or 0)
        player:PrintToPlayer(string.format("Error while zoning. Your position has been reset and %s Gil refunded.", cost), xi.msg.channel.SYSTEM_3)
    end

    clearPlayerVars(player)
end
