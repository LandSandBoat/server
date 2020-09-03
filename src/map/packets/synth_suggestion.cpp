/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "../../common/socket.h"
#include "../map.h"

#include "synth_suggestion.h"
#include <map>

CSynthSuggestionPacket::CSynthSuggestionPacket(uint16 skillID, uint16 skillLevel)
{
	this->type = 0x31;
	this->size = 0x1A;

	char craftname[8];
	memset(craftname, 0, 8);

	switch (skillID)
	{
		//TODO: There might be a better way than this
		//TODO: Also confirm that this order is consistent, else
		//      we might get recipes for the wrong guild
		case(1): strncpy(craftname, "Wood",   8); break;
		case(2): strncpy(craftname, "Smith",  8); break;
		case(3): strncpy(craftname, "Gold",   8); break;
		case(4): strncpy(craftname, "Cloth",  8); break;
		case(5): strncpy(craftname, "Leather",8); break;
		case(6): strncpy(craftname, "Bone",   8); break;
		case(7): strncpy(craftname, "Alchemy",8); break;
		case(8): strncpy(craftname, "Cook",   8); break;
	}

	const char* fmtQuery =
		"SELECT KeyItem, Wood, Smith, Gold, Cloth, Leather, Bone, \
		  Alchemy, Cook, Crystal, Result, Ingredient1, Ingredient2, \
		  Ingredient3, Ingredient4, Ingredient5, Ingredient6, \
		  Ingredient7, Ingredient8 \
		FROM synth_recipes \
		WHERE `%s` >= GREATEST(`Wood`,`Smith`,`Gold`,`Cloth`, \
	          `Bone`,`Alchemy`,`Cook`) AND \
		  %s BETWEEN %u AND %u \
		ORDER BY RAND ( ) \
		LIMIT 1;";

	//TODO: Confirm the conditions under which a recipe can be selected
	//TODO: Is there a better way to run this query than comparing the
	//      craft level of the "main" craft against the craft level of
	//      each craft one at a time to ensure we are only getting
	//      recipes intended for the craft we are seeking to improve?
	int32 ret = Sql_Query(
		SqlHandle,
		fmtQuery,
		craftname, craftname,
		skillLevel + 5, skillLevel + 10);

	if (ret != SQL_ERROR &&
		Sql_NumRows(SqlHandle) != 0 &&
		Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	{
		std::map<uint16, uint16> ingredients;
		uint16 subcraftIDs[3] = {0u,0u,0u};
		size_t subidx = 0;

		// So, each craft can have up to 3 subcrafts. This loop is
		//     to pack the subcraft requirements to be sent
		for (auto i = 1; i < 9; ++i)
		{
			uint16 this_skill = 0u;
			if (i != skillID && subidx < 3)
			{
				this_skill = Sql_GetUIntData(SqlHandle,i);
			}
				
			if (this_skill > 0u)
			{
				subcraftIDs[subidx] = i;
				subidx++;
			}
		}

		ref<uint16>(0x04) = Sql_GetUIntData(SqlHandle,10);
		ref<uint16>(0x06) = subcraftIDs[0];
		ref<uint16>(0x08) = subcraftIDs[1];
		ref<uint16>(0x0A) = subcraftIDs[2];
		ref<uint16>(0x0C) = Sql_GetUIntData(SqlHandle,9);
		ref<uint16>(0x0E) = Sql_GetUIntData(SqlHandle,0);

		// So this loop is a little weird. What we store in the db
		//     is a list of 8 individual ingredients which may or
		//     may not contain duplicates. What we need for the
		//     packet is a set of ingredient and quantity. In order
		//     to achieve that, we're pushing the first instance of
		//     an ingredient into a std::map with a qty 1 and then
		//     any duplicate instances will increase the quantity
		//     without creating new duplicate entries
		for(auto i = 0 ; i < 8; ++i)
		{
			uint16 this_ingredient = 0;

			this_ingredient = Sql_GetUIntData(SqlHandle,11+i);
			if (this_ingredient != 0)
			{
				if (ingredients[this_ingredient])
				{
					ingredients[this_ingredient] = ingredients[this_ingredient] + 1;
				}	
				else
				{
					ingredients[this_ingredient] = 1;
				}
			}
		}

		// Finally, store the contents of the map of ingredients
		//     into the proper offsets in the packet before sending
		uint8 pointer_ref = 0x10u;
		for(auto it = ingredients.begin(); it != ingredients.end(); ++it)
		{
			ref<uint16>(pointer_ref)        = it->first;
			ref<uint16>(pointer_ref + 0x10) = it->second;
			pointer_ref                    += 0x02u;
			if (pointer_ref > 0x1E) { break; }
		}
		ref<uint16>(0x30) = 0x01;
	}
}
