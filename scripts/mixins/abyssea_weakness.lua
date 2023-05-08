-- Abyssea procs mixin
-- Customization:

require("scripts/globals/mixins")
require("scripts/globals/abyssea")
require("scripts/globals/status")

g_mixins = g_mixins or {}

g_mixins.abyssea_weakness = function(mob)
    if mob:isNM() then
        mob:addListener("SPAWN", "ABYSSEA_WEAKNESS_SPAWN", function(mobArg)
            mobArg:setLocalVar("[CanProc]", 1)
            mobArg:setLocalVar("[RedWeakness]", xi.abyssea.getNewRedWeakness(mobArg))
            mobArg:setLocalVar("[AbysseaRedProc]", 0)
            mobArg:setLocalVar("[YellowWeakness]", xi.abyssea.getNewYellowWeakness(mobArg))
            mobArg:setLocalVar("[AbysseaYellowProc]", 0)
            mobArg:setLocalVar("[BlueWeakness]", xi.abyssea.getNewBlueWeakness(mobArg))
            mobArg:setLocalVar("[AbysseaBlueProc]", 0)
        end)

        mob:addListener("ATTACKED", "ATTACKED_ABYSSEA_CHECK_CLAIM", function(mobArg, player, action)
            local claimed = mobArg:getLocalVar("[ClaimedBy]")
            if claimed == 0 then
                mobArg:setLocalVar("[ClaimedBy]", player:getID())
            end
        end)

        mob:addListener("MAGIC_TAKE", "ABYSSEA_MAGIC_PROC_CHECK", function(target, caster, spell)
            if target:canChangeState() then
                if spell:getID() == target:getLocalVar("[YellowWeakness]") then
                    xi.abyssea.procMonster(target, caster, xi.abyssea.triggerType.YELLOW)
                end
            end
        end)

        mob:addListener("WEAPONSKILL_TAKE", "ABYSSEA_WS_PROC_CHECK", function(target, user, wsid)
            if target:canChangeState() then
                if wsid == target:getLocalVar("[RedWeakness]") then
                    xi.abyssea.procMonster(target, user, xi.abyssea.triggerType.RED)
                elseif wsid == target:getLocalVar("[BlueWeakness]") then
                    xi.abyssea.procMonster(target, user, xi.abyssea.triggerType.BLUE)
                end
            end
        end)

        mob:addListener("DEATH", "ABYSSEA_DEATH_NM_KI_DROPCHECK", function(mobArg, player)
            if player ~= nil then
                xi.abyssea.giveNMDrops(mobArg, player, zones[player:getZoneID()])
            end
        end)
    end
end

return g_mixins.abyssea_weakness
