-- Chigoe(pet) family mixin

require('scripts/globals/mixins')

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

g_mixins.families.chigoe = function(chigoeMob)
    -- Chigoes should spawn for the first 5 mobskills
    chigoeMob:addListener('WEAPONSKILL_USE', 'MOB_SPAWN_CHIGOE', function(mobArg)
        local chigoeCount = mobArg:getLocalVar('ChigoeCount')
        local zone        = mobArg:getZone()

        local chigoe = zone:insertDynamicEntity({
            objtype     = xi.objType.MOB,
            name        = 'Chigoe',
            look        = 1747,
            widescan    = 1,
            groupId     = 6,
            groupZoneId = 51,

            onMobSpawn = function(mobArgTwo)
                mobArg:setLocalVar('ChigoeCount', chigoeCount + 1)
                mobArg:setLocalVar('ChigoeCount', 0)

                mobArgTwo:hideName(true)
                mobArgTwo:setUntargetable(true)

                -- Chigoes are usually 7-8 levels lower than their masters
                -- https://www.bg-wiki.com/ffxi/Category:Chigoe
                mobArgTwo:setMobLevel(chigoeMob:getMainLvl() - math.random(7, 9))

                mobArgTwo:addListener('CRITICAL_TAKE', 'CHIGOE_CRITICAL_TAKE', function(mobArgThree)
                    mobArgTwo:setHP(0)
                end)

                mobArgTwo:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(target, wsid)
                    if wsid then
                        target:setHP(0)
                    end
                end)

                mobArgTwo:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(target, user, ability, action)
                    local abilities =
                    {
                        46,  -- Shield Bash
                        66,  -- Jump
                        67,  -- High Jump
                        77,  -- Weapon Bash
                        82,  -- Chi Blast
                        150, -- Tomahawk
                        170, -- Angon
                        201, -- Quickstep
                        202, -- Boxstep
                        203, -- Stutter Step
                        312, -- Feather Step
                    }

                    for _, killAbility in ipairs(abilities) do
                        if ability:getID() == killAbility then
                            mobArgTwo:setHP(0)
                        end
                    end
                end)
            end,

            onMobEngaged = function(mobArgTwo)
                mobArgTwo:hideName(false)
                mobArgTwo:setUntargetable(false)
            end,

            onMobDisengage = function(mobArgTwo)
                mobArgTwo:hideName(true)
                mobArgTwo:setUntargetable(true)
            end,

            onMobDeath = function(mobArgTwo)
                mobArgTwo:removeListener('CHIGOE_CRITICAL_TAKE')
                mobArgTwo:removeListener('CHIGOE_WEAPONSKILL_TAKE')
                mobArgTwo:removeListener('CHIGOE_ABILITY_TAKE')
                mobArg:setLocalVar('ChigoeCount', 0)
            end,
        })

        chigoe:setSpawn(mobArg:getXPos() + 1, mobArg:getYPos() + 1, mobArg:getZPos() + 1, mobArg:getRotPos())

        if chigoeCount < 5 then
            chigoe:spawn()
        end

        chigoe:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING)
        chigoe:setMobMod(xi.mobMod.EXP_BONUS, -100)
    end)
end

return g_mixins.families.chigoe
