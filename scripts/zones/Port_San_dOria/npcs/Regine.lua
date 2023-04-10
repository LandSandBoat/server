-----------------------------------
-- Area: Port San d'Oria
--  NPC: Regine
-- Standard Merchant NPC
-- !pos 68 -9 -74 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/utils")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local flyersForRegine = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)
    local theBrugaireConsortium = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.THE_BRUGAIRE_CONSORTIUM)

    -- FLYERS FOR REGINE
    if
        flyersForRegine == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, { { "gil", 10 } })
    then
        if npcUtil.giveItem(player, xi.items.MAGICMART_FLYER) then
            player:confirmTrade()
        end

    -- THE BRUGAIRE CONSORTIUM
    elseif
        theBrugaireConsortium == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, xi.items.PARCEL_FOR_THE_MAGIC_SHOP)
    then
        player:startEvent(535)
    end
end

entity.onTrigger = function(player, npc)
    local ffr = player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)

    -- FLYERS FOR REGINE
    if ffr == QUEST_AVAILABLE then -- ready to accept quest
        player:startEvent(510, 2)
    elseif
        ffr == QUEST_ACCEPTED and
        utils.mask.isFull(player:getCharVar('[ffr]deliveryMask'), 15)
    then
        -- all 15 flyers delivered
        player:startEvent(603)
    elseif ffr == QUEST_ACCEPTED and not player:hasItem(xi.items.MAGICMART_FLYER) then -- on quest but out of flyers
        player:startEvent(510, 3)

    -- DEFAULT MENU
    else
        player:startEvent(510)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    -- FLYERS FOR REGINE
    if csid == 510 and option == 2 then
        if npcUtil.giveItem(player, { { xi.items.MAGICMART_FLYER, 12 }, { xi.items.MAGICMART_FLYER, 3 } }) then
            player:addQuest(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE)
        end
    elseif csid == 603 then
        npcUtil.completeQuest(
            player, xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.FLYERS_FOR_REGINE,
            {
                gil = 440,
                title = xi.title.ADVERTISING_EXECUTIVE,
                var = '[ffr]deliveryMask',
            }
        )

    -- THE BRUGAIRE CONSORTIUM
    elseif csid == 535 then
        player:confirmTrade()
        player:setCharVar("TheBrugaireConsortium-Parcels", 11)

    -- WHITE MAGIC SHOP
    elseif csid == 510 and option == 0 then
        local stockA =
        {
            4641, 1165, 1, -- Scroll of Diaga
            4664, 837, 1,  -- Scroll of Slow
            4662, 7025, 1, -- Scroll of Stoneskin

            4636, 140, 2,  -- Scroll of Banish
            4646, 1165, 2, -- Scroll of Banishga
            4661, 2097, 2, -- Scroll of Blink
            4610, 585, 2,  -- Scroll of Cure II

            4663, 360, 3,  -- Scroll of Aquaveil
            4624, 990, 3,  -- Scroll of Blindna
            4615, 1363, 3, -- Scroll of Curaga
            4609, 61, 3,   -- Scroll of Cure
            4631, 82, 3,   -- Scroll of Dia
            4623, 324, 3,  -- Scroll of Paralyna
            4622, 180, 3,  -- Scroll of Poisona
            4651, 219, 3,  -- Scroll of Protect
            4656, 1584, 3  -- Scroll of Shell
        }
        xi.shop.nation(player, stockA, xi.nation.SANDORIA)

    -- BLACK MAGIC SHOP
    elseif csid == 510 and option == 1 then
        local stockB =
        {
            4862, 111, 1,  -- Scroll of Blind
            4838, 360, 2,  -- Scroll of Bio
            4828, 82, 2,   -- Scroll of Poison
            4861, 2250, 2, -- Scroll of Sleep

            4762, 324, 3,  -- Scroll of Aero
            4757, 1584, 3, -- Scroll of Blizzard
            4843, 4644, 3, -- Scroll of Burn
            4845, 2250, 3, -- Scroll of Choke
            4848, 6366, 3, -- Scroll of Drown
            4752, 837, 3,  -- Scroll of Fire
            4844, 3688, 3, -- Scroll of Frost
            4846, 1827, 3, -- Scroll of Rasp
            4847, 1363, 3, -- Scroll of Shock
            4767, 61, 3,   -- Scroll of Stone
            4772, 3261, 3, -- Scroll of Thunder
            4777, 140, 3   -- Scroll of Water
        }
        xi.shop.nation(player, stockB, xi.nation.SANDORIA)
    end
end

return entity
