-----------------------------------
-- Area: Southern San d`Oria
--   NPC: Alaune
-- Type: Tutorial NPC
-- !pos -90 1 -56 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/quests/tutorial")
-----------------------------------


function onTrade(player, npc, trade)
    -- "Flyers for Regine" conditional script
    local FlyerForRegine = player:getQuestStatus(SANDORIA, tpz.quest.id.sandoria.FLYERS_FOR_REGINE)

    if FlyerForRegine == 1 then
        local count = trade:getItemCount()
        local MagicFlyer = trade:hasItemQty(532, 1)
        if MagicFlyer and (count == 1) then
            player:messageSpecial(ID.text.FLYER_REFUSED)
        end
    end
end

function onTrigger(player, npc)
    tpz.tutorial.onTrigger(player, npc, 916, 0)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.tutorial.onEventFinish(player, csid, option, 916, 0)
end
