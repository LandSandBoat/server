-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: King Behemoth
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 58) -- 145 total weapaon damage
    mob:setMod(xi.mod.MDEF, 20)
    mob:setMod(xi.mod.ATT, 462)
    mob:setMod(xi.mod.DEF, 500)
    mob:setMod(xi.mod.EVA, 370)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.STUN)

    -- Despawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() > -180 and target:getZPos() > 53,
            target:getXPos() > -230 and target:getZPos() < 5,
        },
        position = mob:getPos(),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    local delay = mob:getLocalVar('delay')
    if
        os.time() > delay and
        mob:canUseAbilities()
    then -- Use Meteor every 40s, based on capture
        mob:castSpell(218, target) -- meteor
        mob:setLocalVar('delay', os.time() + 40)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 20, duration = math.random(4, 8) })
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEHEMOTH_DETHRONER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
