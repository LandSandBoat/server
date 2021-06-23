-----------------------------------
-- Trust: Babban
-----------------------------------
require("scripts/globals/trust")
-----------------------------------
local spell_object = {}

spell_object.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spell_object.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

local isWearingMandragoraGear = function(player)
    local wearingHead = player:getEquipID(xi.slot.HEAD) == 26705 or player:getEquipID(xi.slot.HEAD) == 26706 -- Mandragora Masque or Masque + 1
    local wearingBody = player:getEquipID(xi.slot.BODY) == 27854 or player:getEquipID(xi.slot.BODY) == 27855 -- Mandragora Suit or Suit + 1
    return wearingHead and wearingBody
end

spell_object.onMobSpawn = function(mob)
    local master = mob:getMaster()
    if isWearingMandragoraGear(master) then
        xi.trust.message(mob, xi.trust.message_offset.SPAWN)
    end
end

spell_object.onMobDespawn = function(mob)
    local master = mob:getMaster()
    if isWearingMandragoraGear(master) then
        xi.trust.message(mob, xi.trust.message_offset.DESPAWN)
    end
end

spell_object.onMobDeath = function(mob)
    local master = mob:getMaster()
    if isWearingMandragoraGear(master) then
        xi.trust.message(mob, xi.trust.message_offset.DEATH)
    end
end

return spell_object
