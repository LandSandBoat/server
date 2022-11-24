-----------------------------------
-- ID: 16607
-- Chaosbringer
-----------------------------------
local itemObject = {}

itemObject.onItemDrop = function(player, item)
    player:setCharVar('ChaosbringerKills', 0)
end

itemObject.onItemEquip = function(player, item)
    player:addListener("ENGAGE", "CHAOSBRINGER_KILLS", function(playerArg, mob)
        if mob:getLocalVar("listenerApplied") == 0 then
            mob:addListener("TAKE_DAMAGE", "VALID_KILL", function(mobArg, amount, attacker, attackType, damageType)
                mob:setLocalVar("listenerApplied", 1)
                if
                    (attacker:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED or
                    attacker:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED) and
                    attacker:getEquipID(xi.slot.MAIN) == xi.items.CHAOSBRINGER and
                    attackType == xi.attackType.PHYSICAL and
                    amount > mobArg:getHP()
                then
                    playerArg:incrementCharVar("ChaosbringerKills", 1)
                    print(player:getCharVar("ChaosbringerKills"))
                end
            end)
        end
    end)
end

itemObject.onItemUnequip = function(player, item)
    player:removeListener('CHAOSBRINGER_KILLS')
end

return itemObject
