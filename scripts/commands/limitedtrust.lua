-----------------------------------
-- func: limitedtrust
-- desc: Helper command for casting limited Trusts: Cornelia and Matsui-P
--
-- To use this, you must have the spells available using:
-- !addspell 1002 or !addspell 1003
--
-- You can then summon using:
-- !limitedtrust 0 or !limitedtrust 1
-----------------------------------
require("scripts/globals/trust")
-----------------------------------

cmdprops =
{
    permission = 0,
    parameters = "i"
}

function onTrigger(player, id)

    if id == nil then
        id = 0
    end

    local spell
    if id == 0 then
        spell = GetSpell(1002) -- Cornelia
    elseif id == 1 then
        spell = GetSpell(1003) -- Matsui-P
    end

    if player:hasSpell(spell:getID()) and xi.trust.canCast(player, spell) then
        xi.trust.spawn(player, spell)
    end
end
