-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Ghul-I-Beaban (BLM)
-- BCNM: Undying Promise
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 13)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 8)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobSpawn = function(mob)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local deaths = battlefield:getLocalVar('deaths')

    -- Loses 10% HP per reraise and gains 10% base damage
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 100 + 10 * deaths)
    mob:setHP(math.floor(mob:getMaxHP() * (1 - deaths / 10)))

    if deaths >= 1 then
        local players = battlefield:getPlayers()
        for _, player in pairs(players) do
            if player:isAlive() then
                mob:updateEnmity(player)
                break
            end
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.AERO_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  100 },
        [ 2] = { xi.magic.spell.FIRE_II,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                  100 },
        [ 3] = { xi.magic.spell.THUNDAGA,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                  100 },
        [ 4] = { xi.magic.spell.STONEGA_II, target, false, xi.action.type.DAMAGE_TARGET,        nil,                  100 },
        [ 5] = { xi.magic.spell.DRAIN,      target, false, xi.action.type.DRAIN_HP,             nil,                  100 },
        [ 6] = { xi.magic.spell.ASPIR,      target, false, xi.action.type.DRAIN_MP,             nil,                  100 },
        [ 7] = { xi.magic.spell.SLEEP,      target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    100 },
        [ 8] = { xi.magic.spell.SLEEPGA,    target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,    100 },
        [ 9] = { xi.magic.spell.BIO_II,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BIO,        100 },
        [10] = { xi.magic.spell.ICE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ICE_SPIKES, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

-- On death, store position and increment death count in battlefield local vars so we can use them for respawn
entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()

        if not battlefield then
            return
        end

        local xPos = mob:getXPos()
        local yPos = mob:getYPos()
        local zPos = mob:getZPos()
        local rPos = mob:getRotPos()

        battlefield:setLocalVar('xPos', math.floor(math.abs(xPos) * 100))
        battlefield:setLocalVar('yPos', math.floor(math.abs(yPos) * 100))
        battlefield:setLocalVar('zPos', math.floor(math.abs(zPos) * 100))
        battlefield:setLocalVar('rPos', rPos)
        battlefield:setLocalVar('xPosSign', (xPos < 0) and 1 or 0)
        battlefield:setLocalVar('yPosSign', (yPos < 0) and 1 or 0)
        battlefield:setLocalVar('zPosSign', (zPos < 0) and 1 or 0)

        battlefield:setLocalVar('deaths', battlefield:getLocalVar('deaths') + 1)
    end
end

return entity
