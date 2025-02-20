-----------------------------------
-- Area: Norg
--  NPC: Keal
-- Starts and Ends Quest: It's Not Your Vault
-----------------------------------
local ID = zones[xi.zone.NORG]
-----------------------------------
---@type TNpcEntity
local entity = {}

local pathNodes =
{
    { x = -5.453587, y = 0.151494, z = -16.361458 },
    { x = -5.997250, y = 0.229052, z = -15.475480 },
    { x = -6.582538, y = 0.317294, z = -14.524694 },
    { x = -7.573528, y = 0.365118, z = -12.941586 },
    { x = -7.069273, y = 0.384884, z = -13.867216 },
    { x = -6.565747, y = 0.311785, z = -14.741985 },
    { x = -5.676943, y = 0.173223, z = -16.241194 },
    { x = -5.162223, y = 0.020922, z = -17.108603 },
    { x = -4.725273, y = -0.022554, z = -18.175083 },
    { x = -4.882753, y = -0.041670, z = -19.252790 },
    { x = -5.294413, y = 0.020847, z = -20.336269 },
    { x = -5.632565, y = 0.112649, z = -21.417961 },
    { x = -5.905818, y = 0.202903, z = -22.541668 },
    { x = -5.657803, y = 0.116744, z = -21.445057 },
    { x = -5.273734, y = 0.023316, z = -20.410303 },
    { x = -4.831870, y = -0.049031, z = -19.478870 },
    { x = -4.749702, y = -0.024804, z = -18.311924 },
    { x = -5.152854, y = 0.002354, z = -17.248878 },
    { x = -5.639069, y = 0.185855, z = -16.335281 },
    { x = -6.158780, y = 0.247668, z = -15.445805 },
    { x = -7.253261, y = 0.405026, z = -13.567613 },
    { x = -7.803670, y = 0.348802, z = -12.626184 },
    { x = -8.375298, y = 0.223101, z = -11.645775 },
    { x = -8.895057, y = 0.076541, z = -10.770375 },
    { x = -9.384287, y = 0.015579, z = -9.884774 },
    { x = -9.939011, y = 0.143451, z = -8.935238 },
    { x = -9.422630, y = -0.025280, z = -9.816562 },
    { x = -8.589481, y = 0.151451, z = -11.248314 },
    { x = -8.095008, y = 0.275576, z = -12.123538 },
    { x = -7.561854, y = 0.373715, z = -13.045633 },
    { x = -5.644930, y = 0.185392, z = -16.292952 },
    { x = -5.058481, y = -0.014674, z = -17.285294 },
    { x = -4.724863, y = -0.024709, z = -18.265087 },
    { x = -4.923457, y = -0.042915, z = -19.378429 },
    { x = -5.293544, y = 0.020505, z = -20.338196 },
    { x = -5.606711, y = 0.104830, z = -21.323364 },
    { x = -5.849701, y = 0.183865, z = -22.302536 },
    { x = -5.586438, y = 0.097169, z = -21.222555 },
    { x = -5.214560, y = 0.046522, z = -20.280220 },
    { x = -4.779529, y = -0.048305, z = -19.351633 },
    { x = -4.757209, y = -0.021693, z = -18.194023 },
    { x = -5.138152, y = -0.000450, z = -17.254173 },
    { x = -5.685457, y = 0.173866, z = -16.248564 },
    { x = -6.275849, y = 0.266052, z = -15.243981 },
    { x = -7.196375, y = 0.403362, z = -13.666089 },
    { x = -7.766060, y = 0.352119, z = -12.689950 },
    { x = -8.280642, y = 0.241637, z = -11.799251 },
    { x = -8.828505, y = 0.098458, z = -10.895535 },
    { x = -9.351592, y = 0.039748, z = -9.948843 },
    { x = -9.856394, y = 0.036026, z = -9.068656 },
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    npc:setPos(xi.path.first(pathNodes))
    npc:pathThrough(pathNodes, xi.path.flag.PATROL)
end

entity.onTrigger = function(player, npc)
    local vault = player:getQuestStatus(xi.questLog.OUTLANDS, xi.quest.id.outlands.ITS_NOT_YOUR_VAULT)
    local mLvl = player:getMainLvl()

    if
        vault == xi.questStatus.QUEST_AVAILABLE and
        player:getFameLevel(xi.fameArea.NORG) >= 3 and
        mLvl >= 5
    then
        player:startEvent(36, xi.ki.SEALED_IRON_BOX) -- Start quest
    elseif vault == xi.questStatus.QUEST_ACCEPTED then
        if player:hasKeyItem(xi.ki.SEALED_IRON_BOX) then
            player:startEvent(38) -- Finish quest
        else
            player:startEvent(37, xi.ki.MAP_OF_SEA_SERPENT_GROTTO) -- Reminder/Directions Dialogue
        end
    elseif vault == xi.questStatus.QUEST_COMPLETED then
        player:startEvent(39) -- New Standard Dialogue for everyone who has completed the quest
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 36 and option == 1 then
        player:addQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.ITS_NOT_YOUR_VAULT)
    elseif csid == 38 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.SCROLL_OF_TONKO_ICHI)
        else
            player:delKeyItem(xi.ki.SEALED_IRON_BOX)
            player:addItem(xi.item.SCROLL_OF_TONKO_ICHI) -- Scroll of Tonko: Ichi
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.SCROLL_OF_TONKO_ICHI)
            player:addFame(xi.fameArea.NORG, 50)
            player:completeQuest(xi.questLog.OUTLANDS, xi.quest.id.outlands.ITS_NOT_YOUR_VAULT)
        end
    end
end

return entity
