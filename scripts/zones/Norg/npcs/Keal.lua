-----------------------------------
-- Area: Norg
--  NPC: Keal
-- Starts and Ends Quest: It's Not Your Vault
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/settings")
require("scripts/globals/keyitems")
require("scripts/globals/quests")

local path =
{
    -5.453587, 0.151494, -16.361458,
    -5.997250, 0.229052, -15.475480,
    -6.582538, 0.317294, -14.524694,
    -7.573528, 0.365118, -12.941586,
    -7.069273, 0.384884, -13.867216,
    -6.565747, 0.311785, -14.741985,
    -5.676943, 0.173223, -16.241194,
    -5.162223, 0.020922, -17.108603,
    -4.725273, -0.022554, -18.175083,
    -4.882753, -0.041670, -19.252790,
    -5.294413, 0.020847, -20.336269,
    -5.632565, 0.112649, -21.417961,
    -5.905818, 0.202903, -22.541668,
    -5.657803, 0.116744, -21.445057,
    -5.273734, 0.023316, -20.410303,
    -4.831870, -0.049031, -19.478870,
    -4.749702, -0.024804, -18.311924,
    -5.152854, 0.002354, -17.248878,
    -5.639069, 0.185855, -16.335281,
    -6.158780, 0.247668, -15.445805,
    -7.253261, 0.405026, -13.567613,
    -7.803670, 0.348802, -12.626184,
    -8.375298, 0.223101, -11.645775,
    -8.895057, 0.076541, -10.770375,
    -9.384287, 0.015579, -9.884774,
    -9.939011, 0.143451, -8.935238,
    -9.422630, -0.025280, -9.816562,
    -8.589481, 0.151451, -11.248314,
    -8.095008, 0.275576, -12.123538,
    -7.561854, 0.373715, -13.045633,
    -5.644930, 0.185392, -16.292952,
    -5.058481, -0.014674, -17.285294,
    -4.724863, -0.024709, -18.265087,
    -4.923457, -0.042915, -19.378429,
    -5.293544, 0.020505, -20.338196,
    -5.606711, 0.104830, -21.323364,
    -5.849701, 0.183865, -22.302536,
    -5.586438, 0.097169, -21.222555,
    -5.214560, 0.046522, -20.280220,
    -4.779529, -0.048305, -19.351633,
    -4.757209, -0.021693, -18.194023,
    -5.138152, -0.000450, -17.254173,
    -5.685457, 0.173866, -16.248564,
    -6.275849, 0.266052, -15.243981,
    -7.196375, 0.403362, -13.666089,
    -7.766060, 0.352119, -12.689950,
    -8.280642, 0.241637, -11.799251,
    -8.828505, 0.098458, -10.895535,
    -9.351592, 0.039748, -9.948843,
    -9.856394, 0.036026, -9.068656
}

function onSpawn(npc)
    npc:initNpcAi()
    npc:setPos(tpz.path.first(path))
    -- onPath(npc)
end

function onPath(npc)
    tpz.path.patrol(npc, path)
end

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)

    local Vault = player:getQuestStatus(OUTLANDS, tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT)
    local mLvl = player:getMainLvl()
    local IronBox = player:hasKeyItem(tpz.ki.SEALED_IRON_BOX)

    if (Vault == QUEST_AVAILABLE and player:getFameLevel(NORG) >= 3 and mLvl >= 5) then
        player:startEvent(36, tpz.ki.SEALED_IRON_BOX) -- Start quest
    elseif (Vault == QUEST_ACCEPTED) then
        if (IronBox == true) then
            player:startEvent(38) -- Finish quest
        else
            player:startEvent(37, tpz.ki.MAP_OF_THE_SEA_SERPENT_GROTTO) -- Reminder/Directions Dialogue
        end
    elseif (Vault == QUEST_COMPLETED) then
        player:startEvent(39) -- New Standard Dialogue for everyone who has completed the quest
    else
        player:startEvent(89) -- Standard Conversation
    end

    npc:wait()
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
    if (csid == 36 and option == 1) then
        player:addQuest(OUTLANDS, tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT)
    elseif (csid == 38) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 4961)
        else
            player:delKeyItem(tpz.ki.SEALED_IRON_BOX)
            player:addItem(4961) -- Scroll of Tonko: Ichi
            player:messageSpecial(ID.text.ITEM_OBTAINED, 4961)
            player:addFame(NORG, 50)
            player:completeQuest(OUTLANDS, tpz.quest.id.outlands.ITS_NOT_YOUR_VAULT)
        end
    end

    npc:wait(0)
end
