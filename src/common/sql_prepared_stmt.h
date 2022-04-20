#pragma once

#include <mysql.h>
#include <string>
#include <vector>

#include "sql.h"

class SqlPreparedStatement
{
public:
    SqlPreparedStatement(MYSQL* handle, std::string const& query);
    ~SqlPreparedStatement();

    // TODO: This signature is hard-coded for now
    int32 Execute(MYSQL* handle, uint32 id, std::string varname);

private:
    MYSQL_STMT* m_Statement;
    MYSQL_RES* m_Metadata;
    std::string m_Query;
    std::vector<MYSQL_BIND> m_Fields;
    std::vector<MYSQL_BIND> m_Params;
};
