-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.damage = xi.combat.damage or {}
-----------------------------------

-----------------------------------
-- Physical damage multipliers
-----------------------------------

-----------------------------------
-- Magical damage multipliers
-----------------------------------

-----------------------------------
-- All damage multipliers
-----------------------------------
xi.combat.damage.scarletDeliriumMultiplier = function(actor)
    -- Scarlet delirium are 2 different status effects. SCARLET_DELIRIUM_1 is the one that boosts power.
    if not actor:hasStatusEffect(xi.effect.SCARLET_DELIRIUM_1) then
        return 1
    end

    local scarletDeliriumMultiplier = 1 + actor:getStatusEffect(xi.effect.SCARLET_DELIRIUM_1):getPower() / 1000

    return scarletDeliriumMultiplier
end
