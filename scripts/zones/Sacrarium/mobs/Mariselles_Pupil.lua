-----------------------------------
-- Area: Sacrarium
--  Mob: Mariselles' Pupils
-----------------------------------
local ID = zones[xi.zone.SACRARIUM]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMod(xi.mod.REFRESH, 3)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:setLocalVar('nextSpell', xi.magic.spell.BLIND)
    mob:setLocalVar('spellTimer', GetSystemTime() + 5)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local teleported = mob:getLocalVar('teleported')
    if teleported == 1 then
        mob:castSpell(xi.magic.spell.GRAVITY, target)
        mob:setLocalVar('teleported', 0)
        mob:setLocalVar('nextSpell', xi.magic.spell.BLIND)
        mob:setLocalVar('spellTimer', GetSystemTime() + 20)
    end

    local nextSpell = mob:getLocalVar('nextSpell')
    local spellTimer = mob:getLocalVar('spellTimer')
    if
        GetSystemTime() > spellTimer and
        nextSpell ~= 0
    then
        mob:castSpell(nextSpell, target)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.BLIND then
        mob:setLocalVar('nextSpell', xi.magic.spell.DRAIN)
        mob:setLocalVar('spellTimer', GetSystemTime() + 15)
    elseif spell:getID() == xi.magic.spell.DRAIN then
        mob:setLocalVar('nextSpell', xi.magic.spell.BLIND)
        mob:setLocalVar('spellTimer', GetSystemTime() + 50)
    end
end

entity.onMobDespawn = function(mob)
    local mariselle = GetMobByID(ID.mob.OLD_PROFESSOR_MARISELLE)
    if mariselle and mariselle:isSpawned() then
        mariselle:setLocalVar('petTimer', GetSystemTime() + 10)
    end
end

return entity
