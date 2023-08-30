------------------------------------
-- Custom Module: Chigoes
-- Use: Spawns Chigoes from set mobs
------------------------------------
require('modules/module_utils')
------------------------------------
local m = Module:new('chigoes')

local mobs =
{
    { 'Wajaom_Woodlands',   'Marid'            },
    { 'Wajaom_Woodlands',   'Grand_Marid'      },
    { 'Bhaflau_Thickets',   'Marid'            },
    { 'Bhaflau_Thickets',   'Grand_Marid'      },
    { 'Aydeewa_Subterrane', 'Aydeewa_Diremite' },
    { 'Caedarva_Mire',      'Wild_Karakul'     },
    { 'Caedarva_Mire',      'Mosshorn'         },
}

-- validate that the file exists before trying to override it or weird things happen...
local pathWithFilename = io.popen('cd'):read'*all'

for _, entry in pairs(mobs) do
    local zoneName = entry[1]
    local mobName  = entry[2]
    local filename = pathWithFilename:sub(1, -2) .. string.format('\\scripts\\zones\\%s\\mobs\\%s', zoneName, mobName) .. '.lua'
    local exists   = io.open(filename,'r')

    if exists ~= nil then
        io.close(exists)
    else
        xi.module.ensureTable(string.format('xi.zones.%s.mobs.%s', zoneName, mobName))
    end
end

-- Override for the entries in our mobs table
for _, entry in pairs(mobs) do
    local zoneName    = entry[1]
    local mobName     = entry[2]
    local mobLuaFile  = string.format('xi.zones.%s.mobs.%s.onMobSpawn', zoneName, mobName)

    m:addOverride(mobLuaFile, function(maridMob)
        super(maridMob)

        -- Make sure local var is initialized on spawn & death
        maridMob:addListener('SPAWN', 'MARID_SPAWN', function(mobArg)
            mobArg:setLocalVar('ChigoeCount', 0)
        end)

        maridMob:addListener('DEATH', 'MARID_DEATH', function(mobArg)
            mobArg:setLocalVar('ChigoeCount', 0)
            mobArg:removeListener('MARID_SPAWN_CHIGOE')
        end)

        -- Chigoes should spawn for the first 5 mobskills
        maridMob:addListener('WEAPONSKILL_USE', 'MARID_SPAWN_CHIGOE', function(mobArg)
            local chigoeCount = mobArg:getLocalVar('ChigoeCount')
            local zone        = mobArg:getZone()

            local chigoe = zone:insertDynamicEntity({
                objtype     = xi.objType.MOB,
                name        = 'Chigoe',
                look        = 1747,
                widescan    = 1,
                groupId     = 6,
                groupZoneId = 51,

                onMobInitialize = function(mobArgTwo)
                    g_mixins.families.chigoe(mobArgTwo)
                    mobArgTwo:setMobMod(xi.mobMod.EXP_BONUS, -100)
                end,

                onMobSpawn = function(mobArgTwo)
                    local chigoeCount = mobArg:getLocalVar('ChigoeCount')
                    mobArg:setLocalVar('ChigoeCount', chigoeCount + 1)

                    -- Chigoes are usually 7-8 levels lower than their masters
                    -- https://www.bg-wiki.com/ffxi/Category:Chigoe
                    mobArgTwo:setMobLevel(maridMob:getMainLvl() - math.random(7, 9))

                    mobArgTwo:addListener('SPAWN', 'CHIGOE_SPAWN', function(mobArgThree)
                        mobArgThree:hideName(true)
                        mobArgThree:setUntargetable(true)
                    end)

                    mobArgTwo:addListener('ENGAGE', 'CHIGOE_ENGAGE', function(mobArgThree)
                        mobArgThree:hideName(false)
                        mobArgThree:setUntargetable(false)
                    end)

                    mobArgTwo:addListener('DISENGAGE', 'CHIGOE_DISENGAGE', function(mobArgThree)
                        mobArgThree:hideName(true)
                        mobArgThree:setUntargetable(true)
                    end)

                    mobArgTwo:addListener('CRITICAL_TAKE', 'CHIGOE_CRITICAL_TAKE', function(mobArgThree)
                        mobArgThree:setHP(0)
                    end)

                    mobArgTwo:addListener('WEAPONSKILL_TAKE', 'CHIGOE_WEAPONSKILL_TAKE', function(target, wsid)
                        if wsid then
                            target:setHP(0)
                        end
                    end)

                    mobArgTwo:addListener('ABILITY_TAKE', 'CHIGOE_ABILITY_TAKE', function(ability)
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

                onMobDeath = function(mobArgTwo)
                    mobArgTwo:removeListener('CHIGOE_SPAWN')
                    mobArgTwo:removeListener('CHIGOE_ENGAGE')
                    mobArgTwo:removeListener('CHIGOE_DISENGAGE')
                    mobArgTwo:removeListener('CHIGOE_CRITICAL_TAKE')
                    mobArgTwo:removeListener('CHIGOE_WEAPONSKILL_TAKE')
                    mobArgTwo:removeListener('CHIGOE_ABILITY_TAKE')
                end,
            })

            chigoe:setSpawn(mobArg:getXPos() + 1, mobArg:getYPos() + 1, mobArg:getZPos() + 1, mobArg:getRotPos())

            if chigoeCount < 5 then
                chigoe:spawn()
            end

            chigoe:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING)
        end)
    end)
end

return m
