-- Chigoe(pet) family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local jobAbilities = set{
    xi.jobAbility.SHIELD_BASH,
    xi.jobAbility.JUMP,
    xi.jobAbility.HIGH_JUMP,
    xi.jobAbility.WEAPON_BASH,
    xi.jobAbility.CHI_BLAST,
    xi.jobAbility.TOMAHAWK,
    xi.jobAbility.ANGON,
    xi.jobAbility.QUICKSTEP,
    xi.jobAbility.BOXSTEP,
    xi.jobAbility.STUTTER_STEP,
    xi.jobAbility.FEATHER_STEP,
}

g_mixins.families.chigoe_pet = function(hostMob)
    local ID = zones[hostMob:getZoneID()]

    hostMob:addListener('WEAPONSKILL_USE', 'MOB_SPAWN_CHIGOE', function(mob)
        local mobName = mob:getName()

        if ID.mob.CHIGOES[mobName] == nil then
            return
        end

        for _, mobID in pairs(ID.mob.CHIGOES[mobName]) do
            local chigoe = GetMobByID(mobID)

            if not chigoe:isSpawned() then
                chigoe:setSpawn(hostMob:getXPos() + math.random(-2, 2), hostMob:getYPos() + math.random(-2, 2), hostMob:getZPos() + math.random(-2, 2), hostMob:getRotPos())
                chigoe:spawn()

                chigoe:addListener('CRITICAL_TAKE', 'CHIGOE_CRITICAL_TAKE', function(chigoeMob)
                    chigoeMob:setMobMod(xi.mobMod.EXP_BONUS, -100)
                    chigoeMob:setHP(0)
                end)

                chigoe:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(chigoeMob, wsid)
                    if wsid then
                        chigoeMob:setMobMod(xi.mobMod.EXP_BONUS, -100)
                        chigoeMob:setHP(0)
                    end
                end)

                chigoe:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(chigoeMob, user, ability, action)
                    if jobAbilities[ability:getID()] then
                        chigoeMob:setMobMod(xi.mobMod.EXP_BONUS, -100)
                        chigoeMob:setHP(0)
                    end
                end)

                chigoe:addListener('DEATH', 'CHIGOE_DEATH', function(chigoeMob)
                    chigoeMob:removeListener('CHIGOE_CRITICAL_TAKE')
                    chigoeMob:removeListener('CHIGOE_WEAPONSKILL_TAKE')
                    chigoeMob:removeListener('CHIGOE_ABILITY_TAKE')
                end)

                return
            end
        end
    end)
end

return g_mixins.families.chigoe_pet
