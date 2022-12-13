-----------------------------------
-- Area: Valkurm Dunes
--  NPC: qm4 (???)
-- Involved in quest: Pirate's Chart
-- !pos -160 4 -131 103
-----------------------------------
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local tempitems =
{
    [1]  = 4148, -- Antidoate
    [2]  = 4112, -- Potion
    [3]  = 4113, -- Potion +1
    [4]  = 4114, -- Potion +2
    [5]  = 4115, -- Potion +3
    [6]  = 4206, -- Catholicon
    [7]  = 4202, -- Daedalus Wing
    [8]  = 4151, -- Echo Drops
    [9]  = 4174, -- Elixir
    [10] = 4128, -- Ether
    [11] = 4129, -- Ether +1
    [12] = 4130, -- Ether +2
    [13] = 4131, -- Ether +3
    [14] = 4150, -- Eye Drops
    [15] = 4301, -- Pear au Lait
    [16] = 4164, -- Prism Powder
    [17] = 4155, -- Remedy
    [18] = 4165, -- Silent Oil
    [19] = 4425, -- Tomato Juice
}

local removeTempItems = function(player)
    for _, v in pairs(tempitems) do
        if player:hasItem(v, 3) then
            player:delItem(v, 1, xi.inventoryLocation.TEMPITEMS)
        end
    end
end

entity.onTrade = function(player, npc, trade)
    if player:getPartySize() > 3 then
        player:messageSpecial(ID.text.TOO_MANY_IN_PARTY, 3)
    elseif player:checkSoloPartyAlliance() == 2 then
        player:messageSpecial(ID.text.ALLIANCE_NOT_ALLOWED, 0)
    else
        if npcUtil.tradeHasExactly(trade, xi.items.PIRATES_CHART) then
            player:messageSpecial(ID.text.RETURN_TO_SEA, xi.items.PIRATES_CHART)
            player:startEvent(14, 0, 0, 0, 3)
        end
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    if csid == 14 and option == 0 then
        player:confirmTrade()

        GetNPCByID(ID.npc.PIRATE_CHART_TARU):setAnimation(xi.animation.NONE)
        GetNPCByID(ID.npc.PIRATE_CHART_QM):setStatus(xi.status.DISAPPEAR)
        local party = player:getParty()
        for _, member in pairs(party) do
            member:ChangeMusic(0, 136)
            member:ChangeMusic(1, 136)
            member:ChangeMusic(2, 136)
            member:ChangeMusic(3, 136)
            member:delStatusEffectsByFlag(xi.effectFlag.DISPELABLE)
            removeTempItems(member)
            member:setLocalVar("Chart", 1)
            member:addStatusEffect(xi.effect.LEVEL_RESTRICTION, 20, 0 , 0, 0, 0)
            local effect = member:getStatusEffect(xi.effect.LEVEL_RESTRICTION)
            effect:setFlag(effect:getFlag() + xi.effectFlag.ON_ZONE)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local mobs =
    {
        ID.mob.HOUU_THE_SHOALWADER,
        ID.mob.BEACH_MONK,
        ID.mob.HEIKE_CRAB,
    }

    local function rangeChecking(spawnNpc, spawnerID, timeToMobSpawn, wasInRangeLastCheck, timeOutOfRange)

        local spawner = GetPlayerByID(spawnerID)
        -- spawner does not meet some condition so can stop checking
        -- so will not spawn mobs in any case
        if
            not spawner or
            spawner:getZoneID() ~= spawnNpc:getZoneID() or
            not spawner:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) or
            spawner:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() ~= 20
        then
            return
        end

        --default to in range
        local isInRange = true
        local timeOutOfRangeUpdated = 0
        --if not in range
        if spawner:checkDistance(spawnNpc) > 10 then
            isInRange = false
            timeOutOfRangeUpdated = timeOutOfRange + 500
            --send message if just went out of range or every 5 seconds out of range
            if wasInRangeLastCheck or ((timeOutOfRange % 5000) == 0) then
                spawner:messageSpecial(ID.text.NO_LONGER_FEEL_CHILL)
            end
        end

        --keep scheduling new checks up until the mobs spawn
        if timeToMobSpawn > 500 then
            spawnNpc:timer(500, function(npcArg)
                rangeChecking(spawnNpc, spawnerID, timeToMobSpawn - 500, isInRange, timeOutOfRangeUpdated)
            end)
        end
    end

    if csid == 14 and option == 0 then
        local panictaru  = GetNPCByID(ID.npc.PIRATE_CHART_TARU)
        local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
        local barnacle   = GetNPCByID(ID.npc.BARNACLED_BOX)

        panictaru:setStatus(xi.status.NORMAL)
        -- for some reason the shimmering might not be showing up
        shimmering:setStatus(xi.status.NORMAL)

        -- start range checking for the range message
        rangeChecking(npc, player:getID(), 31000, true, 0)

        -- need to use the qm4 npc for showing text because the taru has a blank name and need a ???
        panictaru:timer(3000 , function(taru) taru:sendNpcEmote(shimmering, xi.emote.POINT, xi.emoteMode.MOTION) npc:showText(npc, ID.text.SHIMMERY_POINT) end)
        panictaru:timer(23000, function(taru) taru:sendNpcEmote(shimmering, xi.emote.PANIC, xi.emoteMode.MOTION) npc:showText(npc, ID.text.HURRY_UP) end)
        panictaru:timer(33000, function(taru) taru:sendNpcEmote(shimmering, xi.emote.PANIC, xi.emoteMode.MOTION) npc:showText(npc, ID.text.ITS_COMING) end)
        panictaru:timer(43000, function(taru) taru:sendNpcEmote(shimmering, xi.emote.PANIC, xi.emoteMode.MOTION) npc:showText(npc, ID.text.THREE_OF_THEM)  end)
        panictaru:timer(45000, function(taru) npc:showText(npc, ID.text.NOOOOO) end)
        panictaru:timer(45000, function(taru) taru:entityAnimationPacket("dead") taru:messageText(taru, ID.text.CRY_OF_ANGUISH, false) end)
        panictaru:timer(50000, function(taru) taru:setStatus(xi.status.DISAPPEAR) taru:entityAnimationPacket("stnd") end)
        npc:timer(50000,
        function(playerArg, npcArg)
            -- make sure player is still here, in the zone, and has correct level restriction
            if
                player and
                player:getZoneID() == xi.zone.VALKURM_DUNES and
                player:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) and
                player:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() == 20
            then

                xi.confrontation.start(player, npc, mobs,
                -- if won then cleanup is done by barnacled box when opened
                function(member)
                    -- allow box to be opened (maybe do not need this here as open is also set when last mob dies)
                    barnacle:setLocalVar("open", 0)
                end,
                -- if lost then do cleanup here for each member
                function(member)
                    -- eventually move shimmering parts to global confrontation cleanup function
                    shimmering:setStatus(xi.status.DISAPPEAR)
                    member:messageSpecial(ID.text.TOO_MUCH_TIME_PASSED)
                    if member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        member:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                    end
                    member:ChangeMusic(0, 0)
                    member:ChangeMusic(1, 0)
                    member:ChangeMusic(2, 101)
                    member:ChangeMusic(3, 102)
                    member:setLocalVar("Chart", 0)
                end
                -- time limit of 10 mins
                , { timeLimit = 600000,
                validPlayerFunc = function(member)
                    -- member must have level 20 restriction to get confrontation status
                    -- this stops cheating like joining party after level restriction but before confrontation
                    if member:hasStatusEffect(xi.effect.LEVEL_RESTRICTION) then
                        return (member:getStatusEffect(xi.effect.LEVEL_RESTRICTION):getPower() == 20)
                    else
                        return false
                    end
                 end,
                -- give all registered players in confrontation emnity
                allRegPlayerEnmity = true }
                )
            -- player does not meet the conditions do not spawn mobs and repop the ???
            else
                GetNPCByID(ID.npc.PIRATE_CHART_QM):setStatus(xi.status.NORMAL)
            end
        end)
    end
end

return entity
