-----------------------------------
-- Area: Leujaoam Sanctum
-- NPC: Nulwahah
-- Assault: Orichalcum Survey
-----------------------------------
local ID = require("scripts/zones/Leujaoam_Sanctum/IDs")
require('scripts/globals/settings')
require("scripts/globals/assault")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    -- Offset to match worms to mining points
    local strikes = npc:getLocalVar("strikeCounter")
    local instance = npc:getInstance()
    local offset = 152

    if npc:checkDistance(player) > 3 then
        player:messageSpecial(ID.text.MOVE_CLOSER)
        return
    end

    if not xi.assault.hasTempItem(player, xi.items.PICKAXE) then
        player:messageSpecial(ID.text.MINING_POSSIBLE, xi.items.PICKAXE)
        return
    end

    if GetMobByID(npc:getID() - offset, instance):isSpawned() then
        player:messageSpecial(ID.text.CANT_MINE)
        return
    end

    if strikes < 8 then
        player:sendEmote(GetNPCByID(npc:getID(), instance), xi.emote.EXCAVATION, xi.emoteMode.MOTION, true)
        npc:setLocalVar("strikeCounter", strikes + 1)
        local rand = math.random(1, 100)

        -- Sample rate: 205
        --   162 / 205 nothing (~79%)
        --   26  / 205 worm    (~12%)
        --   15  / 205 pebble  (~8%)
        --   2   / 205 ore     (~1%)
        if rand < 79 then
            player:messageSpecial(ID.text.FIND_NOTHING) -- nothing

        elseif rand < 91 then
            local worm = GetMobByID(npc:getID() - offset, instance)
            worm:spawn()
            worm:updateEnmity(player)

        elseif rand < 99 then
            npcUtil.giveItem(player, xi.items.PEBBLE)

        else
            npcUtil.giveTempItem(player, xi.items.CHUNK_OF_ORICHALCUM_ORE)
            instance:setProgress(1)

            for _, qiqirn in pairs(ID.mob[xi.assault.mission.ORICHALCUM_SURVEY].MOBS_START) do
                GetMobByID(qiqirn, instance):setAggressive(true)
            end
        end

        -- Sample rate: 205
        -- 3% chance to break
        if math.random(1, 100) < 3 then
            player:messageSpecial(ID.text.PICKAXE_BREAKS, xi.items.PICKAXE)
            xi.assault.delTempItem(player, xi.items.PICKAXE)
        end

        -- If node has been struck 8 times, hide for 5 minutes and reset
        if strikes + 1 == 8 then
            npc:hideNPC(300)
            npc:setLocalVar("strikeCounter", 0)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
