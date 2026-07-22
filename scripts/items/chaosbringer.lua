-----------------------------------
-- ID: 16607
-- Chaosbringer
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemDrop = function(target, item, recycleBin)
    if not recycleBin then
        target:setCharVar('ChaosbringerKills', 0)
    end
end

itemObject.onItemEquip = function(target, item)
    target:addListener('ATTACK', 'CHAOSBRINGER_ATTACK', function(attacker, attackTarget, action)
        if
            attackTarget:getHP() == 0 and
            (attacker:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == xi.questStatus.QUEST_ACCEPTED or
            attacker:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == xi.questStatus.QUEST_ACCEPTED) and
            attacker:getCharVar('ChaosbringerKills') < 200
        then
            attacker:incrementCharVar('ChaosbringerKills', 1)
        end
    end)
end

itemObject.onItemUnequip = function(target, item)
    target:removeListener('CHAOSBRINGER_ATTACK')
end

return itemObject
