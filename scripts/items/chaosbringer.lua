-----------------------------------
-- ID: 16607
-- Chaosbringer
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(target, item)
    target:setCharVar('ChaosbringerKills', 0)
end

itemObject.onItemEquip = function(target, item)
    target:addListener('DEFEATED_MOB', 'CHAOSBRINGER_KILLS', function(mob, player, optParams)
        if
            (player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED or
            player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED) and
            target:getCharVar('ChaosbringerKills') < 200 and
            optParams.isKiller and
            not optParams.isWeaponSkillKill
        then
            player:incrementCharVar('ChaosbringerKills', 1)
        end
    end)
end

itemObject.onItemUnequip = function(target, item)
    target:removeListener('CHAOSBRINGER_KILLS')
end

return itemObject
