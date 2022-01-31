--------------------------------------------------------------
-- func: @catseye <page number>
-- desc: opens the custom shop
--------------------------------------------------------------
require("scripts/globals/keyitems");

cmdprops =
{
    permission = 0,
    parameters = "i"
};

function onTrigger(player,page)

    if (page == 0 or page == nil) then
        player:PrintToPlayer( "CatsEye: 1: Food, 2: Santion, 3: Sigil, 4: Signet", 0x1F)
    elseif (page == 1) then -- Food
        local stock_1 =
        {
			4421, 2400, -- Melon Pie
			4488, 3000, -- Jaco
			4558, 4000, -- Yagudo
			5149, 6000, -- SoleSushi
			4381, 6000, -- MeatKabob
			5174, 5000, -- Tav-Taco
			6464, 5000, -- BeheSteak
        }
        xi.shop.general(player, stock_1)
        player:PrintToPlayer( "CatsEye: Welcome to the Food Depot!", 0x1F)
    elseif (page == 2) then -- Sanction
	
		player:PrintToPlayer("CatsEye: Enjoy sanction!",0x1F)
		player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
		player:addStatusEffect(xi.effect.SANCTION, 0, 0, 15000)

	elseif (page == 3) then -- Sigil
	
		player:PrintToPlayer("CatsEye: Enjoy sigil!",0x1F)
		player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
		player:addStatusEffect(xi.effect.SIGIL, 0, 0, 15000)
    
	elseif (page == 4) then
		
		player:PrintToPlayer("CatsEye: Enjoy signet!",0x1F)
		player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
		player:addStatusEffect(xi.effect.SIGNET, 0, 0, 15000)


       else
        player:PrintToPlayer( string.format( "The CatsEye catalog doesn't have a page %i, Kupo!", page ) )
	end
end