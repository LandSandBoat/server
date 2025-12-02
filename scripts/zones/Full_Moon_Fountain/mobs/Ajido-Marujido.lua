-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Ajido-Marujido
-- Ally during Windurst Mission 9-2
-- TODO: Fix visibility if warp takes Ajido farther than 30' from a player
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
mixins = { require('scripts/mixins/helper_npc') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Teleport configuration per battlefield area
local teleportConfig =
{
    [1] =
    { -- Battlefield area 1
        positions =
        {
            { x = 320.00, y = 48.00, z = -352.00 },
            { x = 358.00, y = 48.00, z = -352.00 },
            { x = 340.11, y = 48.75, z = -383.74 },
        },
    },
    [2] =
    { -- Battlefield area 2
        positions =
        {
            { x = -38.09, y = 10.00, z = 51.96 },
            { x = -80.09, y = 10.00, z = 51.96 },
            { x = -59.98, y = 10.75, z = 16.22 },
        },
    },
    [3] =
    { -- Battlefield area 3
        positions =
        {
            { x = -357.94, y = -52.00, z = 411.97 },
            { x = -403.94, y = -52.00, z = 411.97 },
            { x = -379.82, y = -51.25, z = 376.23 },
        },
    },
}

local helperConfig =
{
    engageWaitTime = 90, -- 1.5 minutes
    targetMobs = function(mob)
        local battlefieldArea = mob:getBattlefield():getArea()
        local areaOffset = (battlefieldArea - 1) * 6
        return
        {
            ID.mob.ACE_OF_CUPS + areaOffset + 5, -- Yali
            ID.mob.ACE_OF_CUPS + areaOffset + 4, -- Tatzlwurm
        }
    end,
}

entity.onMobSpawn = function(mob)
    xi.mix.helperNpc.config(mob, helperConfig)
    mob:setMagicCastingEnabled(false)

    mob:addListener('MAGIC_START', 'MAGIC_MSG', function(ajidoMob, spell, action)
        local spellId = spell:getID()
        if spellId == xi.magic.spell.BURST then
            ajidoMob:showText(ajidoMob, ID.text.PLAY_TIME_IS_OVER)
        elseif spellId == xi.magic.spell.FLOOD then
            ajidoMob:showText(ajidoMob, ID.text.YOU_SHOULD_BE_THANKFUL)
        end
    end)

    -- Teleport when taking damage
    mob:addListener('TAKE_DAMAGE', 'AJIDO_TAKE_DAMAGE', function(ajidoMob, damage, attacker, attackType, damageType)
        if damage > 30 and GetSystemTime() > ajidoMob:getLocalVar('teleportTime') then
            ajidoMob:setMagicCastingEnabled(false)
            ajidoMob:setLocalVar('warpInProgress', 1)
            ajidoMob:useMobAbility(xi.mobSkill.AJIDO_WARP_OUT, nil, 0)
        end
    end)

    mob:addListener('WEAPONSKILL_STATE_EXIT', 'WARP_OUT_COMPLETE', function(ajidoMob, skillId)
        if skillId == xi.mobSkill.AJIDO_WARP_OUT then
            local battlefieldArea = ajidoMob:getBattlefield():getArea()
            local config = teleportConfig[battlefieldArea]

            if config and config.positions then
                -- Select a random position from available teleport locations
                local targetPosition = utils.randomEntry(config.positions)

                if targetPosition then
                    ajidoMob:setPos(targetPosition.x, targetPosition.y, targetPosition.z, ajidoMob:getRotPos())
                    ajidoMob:queue(0, function(mobArg)
                        mobArg:useMobAbility(xi.mobSkill.AJIDO_WARP_IN, nil, 0)
                    end)
                end
            end
        elseif skillId == xi.mobSkill.AJIDO_WARP_IN then
            local currentTime = GetSystemTime()
            ajidoMob:setMagicCastingEnabled(true)
            ajidoMob:setLocalVar('warpInProgress', 0)
            ajidoMob:setLocalVar('teleportTime', currentTime + 5)
        end
    end)
end

entity.onMobEngage = function(mob, target)
    local currentTime = GetSystemTime()
    mob:setLocalVar('magicWait', currentTime + 30)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() < 50 and mob:getLocalVar('saidMessage') == 0 then
        mob:showText(mob, ID.text.DONT_GIVE_UP)
        mob:setLocalVar('saidMessage', 1)
    end

    -- Wait 30 seconds to start casting (but only if not in warp process)
    if mob:getLocalVar('warpInProgress') == 0 then
        local currentTime = GetSystemTime()
        local magicWait = mob:getLocalVar('magicWait')
        if currentTime > magicWait then
            mob:setMagicCastingEnabled(true)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
    local players = mob:getBattlefield():getPlayers()
    for _, playerObj in pairs(players) do
        playerObj:messageSpecial(ID.text.UNABLE_TO_PROTECT)
    end
end

return entity
