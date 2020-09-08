-----------------------------------
-- Area: Fei'Yin
--  NPC: Seed Afterglow
-- !pos -94.342 -15.656 -85.889 204     Red
-- !pos -52.019 -16.525 38.848 204      Orange
-- !pos 36.000 -15.000 -35.000 204      Green
-- !pos 74.611 -16.123 134.570 204      Yellow
-- !pos -6.710  0.462 210.245 204       Cerulean
-- !pos -200.000 -15.425 120.000 204    Blue
-- !pos -168.000 0.114 130.000 204      Golden
-- !pos -130.000 0.113 8.000 204        Silver
-- !pos -50.000 0.114 32.000 204        White
-- Todo: NPC moving. In retail these move around with 3-5+ pos EACH
-----------------------------------
local ID = require("scripts/zones/FeiYin/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/status")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local offset        = npc:getID() - ID.npc.AFTERGRLOW_OFFSET
    local ACP           = player:getCurrentMission(ACP)
    local currentDay    = tonumber(os.date("%j"))
    local needToZone    = player:needToZone()
    local progressMask  = player:getCharVar("SEED_AFTERGLOW_MASK")
    local intensity     = player:getCharVar("SEED_AFTERGLOW_INTENSITY")

    if (
        player:hasKeyItem(tpz.ki.MARK_OF_SEED) or
        player:hasKeyItem(tpz.ki.AZURE_KEY) or
        player:hasKeyItem(tpz.ki.IVORY_KEY) or
        CurrentDay == player:getCharVar("LastAzureKey") or
        CurrentDay == player:getCharVar("LastIvoryKey") or
        ACP < tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II
    ) then
        player:messageSpecial(ID.text.SOFTLY_SHIMMERING_LIGHT)

    elseif (needToZone and not player:hasStatusEffect(tpz.effect.MARK_OF_SEED)) then
        player:messageSpecial(ID.text.YOU_REACH_FOR_THE_LIGHT)
    elseif (ACP >= tpz.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II and not player:getMaskBit(progressMask, offset)) then
        player:setMaskBit(progressMask, "SEED_AFTERGLOW_MASK", offset, true)
        intensity = intensity + 1
        if (intensity == 9) then
            player:startEvent(28)
        elseif (not needToZone and not player:hasStatusEffect(tpz.effect.MARK_OF_SEED)) then
            player:setCharVar("SEED_AFTERGLOW_INTENSITY", intensity)
            player:messageSpecial(ID.text.YOU_REACH_OUT_TO_THE_LIGHT, 0)
            player:addStatusEffectEx(tpz.effect.MARK_OF_SEED, 0, 0, 30, 1800)
            player:needToZone(true)
            player:messageSpecial(ID.text.THE_LIGHT_DWINDLES, 0)
        else
            player:setCharVar("SEED_AFTERGLOW_INTENSITY", intensity)
            player:messageSpecial(ID.text.EVEN_GREATER_INTENSITY, offset)
        end

    else
        player:messageSpecial(ID.text.SOFTLY_SHIMMERING_LIGHT)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 28 then
        player:delStatusEffectSilent(tpz.effect.MARK_OF_SEED)

        if option == 100 then
            player:messageSpecial(ID.text.SCINTILLATING_BURST_OF_LIGHT)
            npcUtil.giveKeyItem(player, tpz.ki.MARK_OF_SEED)
        elseif option == 200 then
            npcUtil.giveKeyItem(player, tpz.ki.AZURE_KEY)
        end
    end
end
