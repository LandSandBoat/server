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
    [1]  = 4148,-- Antidoate
    [2]  = 4112,-- Potion
    [3]  = 4113,-- Potion +1
    [4]  = 4114,-- Potion +2
    [5]  = 4115,-- Potion +3
    [6]  = 4206,-- Catholicon
    [7]  = 4202,-- Daedalus Wing
    [8]  = 4151,-- Echo Drops
    [9]  = 4174,-- Elixir
    [10] = 4128,-- Ether
    [11] = 4129,-- Ether +1
    [12] = 4130,-- Ether +2
    [13] = 4131,-- Ether +3
    [14] = 4150,-- Eye Drops
    [15] = 4301,-- Pear au Lait
    [16] = 4164,-- Prism Powder
    [17] = 4155,-- Remedy
    [18] = 4165,-- Silent Oil
    [19] = 4425,-- Tomato Juice
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
        for _,member in pairs(party) do
            member:ChangeMusic(0, 136)
            member:ChangeMusic(1, 136)
            member:ChangeMusic(2, 136)
            member:ChangeMusic(3, 136)
            member:delStatusEffectsByFlag(xi.effectFlag.DISPELABLE)
            removeTempItems(member)
            member:setLocalVar("Chart", 1)
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

    if csid == 14 and option == 0 then
        local panictaru  = GetNPCByID(ID.npc.PIRATE_CHART_TARU)
        local shimmering = GetNPCByID(ID.npc.SHIMMERING_POINT)
        local barnacle   = GetNPCByID(ID.npc.BARNACLED_BOX)

        panictaru:setStatus(xi.status.NORMAL)
        shimmering:setStatus(xi.status.NORMAL)
        player:addPartyEffect(xi.effect.LEVEL_RESTRICTION, xi.effect.LEVEL_RESTRICTION, 20, 0, 0, 0, 0)
        panictaru:timer(3000 , function(taru) taru:sendNpcEmote(shimmering, xi.emote.POINT, xi.emoteMode.MOTION) npc:showText(npc, ID.text.SHIMMERY_POINT) end)
        panictaru:timer(23000, function(taru) taru:sendNpcEmote(shimmering, xi.emote.PANIC, xi.emoteMode.MOTION) npc:showText(npc, ID.text.HURRY_UP) end)
        panictaru:timer(33000, function(taru) taru:sendNpcEmote(shimmering, xi.emote.PANIC, xi.emoteMode.MOTION) npc:showText(npc, ID.text.ITS_COMING) end)
        panictaru:timer(43000, function(taru) taru:sendNpcEmote(shimmering, xi.emote.PANIC, xi.emoteMode.MOTION) npc:showText(npc, ID.text.THREE_OF_THEM)  end)
        panictaru:timer(45000, function(taru) taru:showText(npc, ID.text.NOOOOO) end)
        panictaru:timer(45000, function(taru) taru:entityAnimationPacket("dead") shimmering:showText(npc, ID.text.CRY_OF_ANGUISH) end)
        panictaru:timer(50000, function(taru) taru:setStatus(xi.status.DISAPPEAR) npc:entityAnimationPacket("stnd") end)
        player:timer(50000, function(playerArg, npcArg)
            xi.confrontation.start(player, npc, mobs, function(member)
                player:delStatusEffect(xi.effect.LEVEL_RESTRICTION)
                barnacle:setStatus(xi.status.NORMAL)
                barnacle:setLocalVar("open", 0)
            end)
        end)
    end
end

return entity
