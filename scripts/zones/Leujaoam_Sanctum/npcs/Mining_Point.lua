-----------------------------------
-- Area: Leujaoam Sanctum
-- NPC: Mining Point
-- Assault: Orichalcum Survey
-- IDs 17060016 - 17060025
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------
local entity = {}

local handleMiningPoint = function(npc)
    local instance = npc:getInstance()
    local Mined = npc:getLocalVar("Mined")
    npc:setLocalVar("Mined", Mined - 1)

    if Mined <= 0 then
        local miningPoints = utils.shuffle(ID.mob[ORICHALCUM_SURVEY].MINING_POINTS)

        for _, point in pairs(miningPoints) do
            local npcObj = GetNPCByID(point, instance)
            if npcObj:getStatus() == xi.status.DISAPPEAR then
                npcObj:setStatus(xi.status.NORMAL)
                npcObj:setLocalVar("Mined", math.random(5,10))
                break
            end
        end
        npc:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onTrigger = function(player, npc)
    local instance = npc:getInstance()
    local chance = math.random(1, 1000)
    local pickBreak = math.random(1, 100)
    local mineralEater = npc:getID() - 152
    local currentTime = os.time()

    if npc:checkDistance(player) > 3 then
        player:messageSpecial(ID.text.MINE_TOO_FAR)
        return
    elseif not player:hasItem(605, xi.inventoryLocation.TEMPITEMS) then -- Pickaxe
        player:messageSpecial(ID.text.MINE_NO_PICK, 605)
        return
    elseif GetMobByID(mineralEater, instance):isSpawned() or npc:getLocalVar("Wait") >= currentTime then
        player:messageSpecial(ID.text.CANT_MINE)
        return
    end

    if chance >= 30 then
        player:sendEmote(npc, xi.emote.EXCAVATION, xi.emoteMode.MOTION, true)
        npc:setLocalVar("Wait", currentTime + 3)
        if chance > 900 then -- items
            if chance > 990 then
                player:timer(3000, function(player)
                player:addTempItem(739) -- Chunk of Orichalcum Ore
                player:messageSpecial(ID.text.MINE_SUCCESS, 739)
                instance:setStage(1) end)
            else
                player:timer(3000, function(player)
                player:addTreasure(17296, GetNPCByID(17060016, instance)) end) -- Pebble
            end
        elseif chance < 100 then
            player:timer(3000, function(player)
            player:messageSpecial(ID.text.MINE_FAIL)
            SpawnMob(mineralEater, instance):updateEnmity(player) end)
        else
            player:timer(3000, function(player)
            player:messageSpecial(ID.text.MINE_FAIL) end)
        end
        if pickBreak >= 900 then
            player:timer(3000, function(player)
            player:messageSpecial(ID.text.BREAK_PICKAXE, 605) -- Pickaxe
            player:delItem(605, 1, xi.inventoryLocation.TEMPITEMS) end)
        end
    else
        SpawnMob(mineralEater, instance):updateEnmity(player)
    end
    handleMiningPoint(npc)
end

return entity
