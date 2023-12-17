/************************************************************************************
   Copyright (C) 2020 MariaDB Corporation AB

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; if not see <http://www.gnu.org/licenses>
   or write to the Free Software Foundation, Inc.,
   51 Franklin St., Fifth Floor, Boston, MA 02110, USA
*************************************************************************************/


#ifndef _DatabaseMetaData_H_
#define _DatabaseMetaData_H_

#include <list>
#include "buildconf.hpp"

namespace sql
{

class MARIADB_EXPORTED DatabaseMetaData
{
  DatabaseMetaData(const DatabaseMetaData &);
  void operator=(DatabaseMetaData &);
public:
  enum
  {
    attributeNoNulls= 0,
    attributeNullable,
    attributeNullableUnknown
  };
  enum
  {
    bestRowUnknown= 0,
    bestRowNotPseudo,
    bestRowPseudo
  };
  enum
  {
    bestRowTemporary= 0,
    bestRowTransaction,
    bestRowSession
  };
  enum
  {
    columnNoNulls= 0,
    columnNullable,
    columnNullableUnknown
  };
  enum
  {
    functionColumnUnknown= 0,
    functionColumnIn,
    functionColumnInOut,
    functionColumnOut,
    functionReturn= 4,
    functionColumnResult= 5
    
  };
  enum
  {
    functionNoNulls = 0,
    functionNullable,
    functionNullableUnknown
  };
  enum
  {
    functionResultUnknown= 0,
    functionNoTable,
    functionReturnsTable,
  };
  enum
  {
    importedKeyCascade= 0,
    importedKeyRestrict,
    importedKeySetNull,
    importedKeyNoAction,
    importedKeySetDefault,
    
    importedKeyInitiallyDeferred= 5,
    importedKeyInitiallyImmediate,
    importedKeyNotDeferrable
  };
  enum
  {
    procedureColumnUnknown= 0,
    procedureColumnIn,
    procedureColumnInOut,
    procedureColumnResult,
    procedureColumnOut,
    procedureColumnReturn
  };
  enum
  {
    procedureNoNulls= 0,
    procedureNullable,
    procedureNullableUnknown
  };
  enum
  {
    procedureResultUnknown= 0,
    procedureNoResult,
    procedureReturnsResult
  };
  enum
  {
    sqlStateXOpen= 1,
    sqlStateSQL,
    sqlStateSQL99= 2
  };
  enum
  {
    tableIndexStatistic= 0,
    tableIndexClustered,
    tableIndexHashed,
    tableIndexOther
  };
  enum
  {
    typeNoNulls= 0,
    typeNullable,
    typeNullableUnknown
  };
  enum
  {
    typePredNone= 0,
    typePredChar,
    typePredBasic,
    typeSearchable
  };
  enum
  {
    versionColumnUnknown= 0,
    versionColumnNotPseudo,
    versionColumnPseudo
  };

  DatabaseMetaData() {}
  virtual ~DatabaseMetaData(){}

  virtual ResultSet* getImportedKeys(const SQLString& catalog, const SQLString& schema, const SQLString& table)=0;
  virtual ResultSet* getPrimaryKeys(const SQLString& catalog, const SQLString& schema, const SQLString& table)=0;
  virtual ResultSet* getTables(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& tableNamePattern,
                      std::list<SQLString>& types)=0;
  virtual ResultSet* getColumns(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& tableNamePattern, const SQLString& columnNamePattern)=0;
  virtual ResultSet* getExportedKeys(const SQLString& catalog, const SQLString& schema, const SQLString& table)=0;
  virtual ResultSet* getBestRowIdentifier(const SQLString& catalog, const SQLString& schema, const SQLString& table, int32_t scope, bool nullable)=0;
  virtual bool generatedKeyAlwaysReturned()=0;
  virtual ResultSet* getPseudoColumns(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& tableNamePattern, const SQLString& columnNamePattern)=0;
  virtual bool allProceduresAreCallable()=0;
  virtual bool allTablesAreSelectable()=0;
  virtual SQLString getURL()=0;
  virtual SQLString getUserName()=0;
  virtual bool isReadOnly()=0;
  virtual bool nullsAreSortedHigh()=0;
  virtual bool nullsAreSortedLow()=0;
  virtual bool nullsAreSortedAtStart()=0;
  virtual bool nullsAreSortedAtEnd()=0;
  virtual SQLString getDatabaseProductName()=0;
  virtual SQLString getDatabaseProductVersion()=0;
  virtual SQLString getDriverName()=0;
  virtual SQLString getDriverVersion()=0;
  virtual int32_t getDriverMajorVersion()=0;
  virtual int32_t getDriverMinorVersion()=0;
  virtual int32_t getDriverPatchVersion()=0;
  virtual bool usesLocalFiles()=0;
  virtual bool usesLocalFilePerTable()=0;
  virtual bool supportsMixedCaseIdentifiers()=0;
  virtual bool storesUpperCaseIdentifiers()=0;
  virtual bool storesLowerCaseIdentifiers()=0;
  virtual bool storesMixedCaseIdentifiers()=0;
  virtual bool supportsMixedCaseQuotedIdentifiers()=0;
  virtual bool storesUpperCaseQuotedIdentifiers()=0;
  virtual bool storesLowerCaseQuotedIdentifiers()=0;
  virtual bool storesMixedCaseQuotedIdentifiers()=0;
  virtual SQLString getIdentifierQuoteString()=0;
  virtual SQLString getSQLKeywords()=0;
  virtual SQLString getNumericFunctions()=0;
  virtual SQLString getStringFunctions()=0;
  virtual SQLString getSystemFunctions()=0;
  virtual SQLString getTimeDateFunctions()=0;
  virtual SQLString getSearchStringEscape()=0;
  virtual SQLString getExtraNameCharacters()=0;
  virtual bool supportsAlterTableWithAddColumn()=0;
  virtual bool supportsAlterTableWithDropColumn()=0;
  virtual bool supportsColumnAliasing()=0;
  virtual bool nullPlusNonNullIsNull()=0;
  virtual bool supportsConvert()=0;
  virtual bool supportsConvert(int32_t fromType,int32_t toType)=0;
  virtual bool supportsTableCorrelationNames()=0;
  virtual bool supportsDifferentTableCorrelationNames()=0;
  virtual bool supportsExpressionsInOrderBy()=0;
  virtual bool supportsOrderByUnrelated()=0;
  virtual bool supportsGroupBy()=0;
  virtual bool supportsGroupByUnrelated()=0;
  virtual bool supportsGroupByBeyondSelect()=0;
  virtual bool supportsLikeEscapeClause()=0;
  virtual bool supportsMultipleResultSets()=0;
  virtual bool supportsMultipleTransactions()=0;
  virtual bool supportsNonNullableColumns()=0;
  virtual bool supportsMinimumSQLGrammar()=0;
  virtual bool supportsCoreSQLGrammar()=0;
  virtual bool supportsExtendedSQLGrammar()=0;
  virtual bool supportsANSI92EntryLevelSQL()=0;
  virtual bool supportsANSI92IntermediateSQL()=0;
  virtual bool supportsANSI92FullSQL()=0;
  virtual bool supportsIntegrityEnhancementFacility()=0;
  virtual bool supportsOuterJoins()=0;
  virtual bool supportsFullOuterJoins()=0;
  virtual bool supportsLimitedOuterJoins()=0;
  virtual SQLString getSchemaTerm()=0;
  virtual SQLString getProcedureTerm()=0;
  virtual SQLString getCatalogTerm()=0;
  virtual bool isCatalogAtStart()=0;
  virtual SQLString getCatalogSeparator()=0;
  virtual bool supportsSchemasInDataManipulation()=0;
  virtual bool supportsSchemasInProcedureCalls()=0;
  virtual bool supportsSchemasInTableDefinitions()=0;
  virtual bool supportsSchemasInIndexDefinitions()=0;
  virtual bool supportsSchemasInPrivilegeDefinitions()=0;
  virtual bool supportsCatalogsInDataManipulation()=0;
  virtual bool supportsCatalogsInProcedureCalls()=0;
  virtual bool supportsCatalogsInTableDefinitions()=0;
  virtual bool supportsCatalogsInIndexDefinitions()=0;
  virtual bool supportsCatalogsInPrivilegeDefinitions()=0;
  virtual bool supportsPositionedDelete()=0;
  virtual bool supportsPositionedUpdate()=0;
  virtual bool supportsSelectForUpdate()=0;
  virtual bool supportsStoredProcedures()=0;
  virtual bool supportsSubqueriesInComparisons()=0;
  virtual bool supportsSubqueriesInExists()=0;
  virtual bool supportsSubqueriesInIns()=0;
  virtual bool supportsSubqueriesInQuantifieds()=0;
  virtual bool supportsCorrelatedSubqueries()=0;
  virtual bool supportsUnion()=0;
  virtual bool supportsUnionAll()=0;
  virtual bool supportsOpenCursorsAcrossCommit()=0;
  virtual bool supportsOpenCursorsAcrossRollback()=0;
  virtual bool supportsOpenStatementsAcrossCommit()=0;
  virtual bool supportsOpenStatementsAcrossRollback()=0;
  virtual int32_t getMaxBinaryLiteralLength()=0;
  virtual int32_t getMaxCharLiteralLength()=0;
  virtual int32_t getMaxColumnNameLength()=0;
  virtual int32_t getMaxColumnsInGroupBy()=0;
  virtual int32_t getMaxColumnsInIndex()=0;
  virtual int32_t getMaxColumnsInOrderBy()=0;
  virtual int32_t getMaxColumnsInSelect()=0;
  virtual int32_t getMaxColumnsInTable()=0;
  virtual int32_t getMaxConnections()=0;
  virtual int32_t getMaxCursorNameLength()=0;
  virtual int32_t getMaxIndexLength()=0;
  virtual int32_t getMaxSchemaNameLength()=0;
  virtual int32_t getMaxProcedureNameLength()=0;
  virtual int32_t getMaxCatalogNameLength()=0;
  virtual int32_t getMaxRowSize()=0;
  virtual bool doesMaxRowSizeIncludeBlobs()=0;
  virtual int32_t getMaxStatementLength()=0;
  virtual int32_t getMaxStatements()=0;
  virtual int32_t getMaxTableNameLength()=0;
  virtual int32_t getMaxTablesInSelect()=0;
  virtual int32_t getMaxUserNameLength()=0;
  virtual int32_t getDefaultTransactionIsolation()=0;
  virtual bool supportsTransactions()=0;
  virtual bool supportsTransactionIsolationLevel(int32_t level)=0;
  virtual bool supportsDataDefinitionAndDataManipulationTransactions()=0;
  virtual bool supportsDataManipulationTransactionsOnly()=0;
  virtual bool dataDefinitionCausesTransactionCommit()=0;
  virtual bool dataDefinitionIgnoredInTransactions()=0;
  virtual ResultSet* getProcedures(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& procedureNamePattern)=0;
  virtual ResultSet* getProcedureColumns(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& procedureNamePattern, const SQLString& columnNamePattern)=0;
  virtual ResultSet* getFunctionColumns(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& functionNamePattern, const SQLString& columnNamePattern)=0;
  virtual ResultSet* getSchemas()=0;
  virtual ResultSet* getSchemas(const SQLString& catalog, const SQLString& schemaPattern)=0;
  virtual ResultSet* getCatalogs()=0;
  virtual ResultSet* getTableTypes()=0;
  virtual ResultSet* getColumnPrivileges(const SQLString& catalog, const SQLString& schema, const SQLString& table, const SQLString& columnNamePattern)=0;
  virtual ResultSet* getTablePrivileges(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& tableNamePattern)=0;
  virtual ResultSet* getVersionColumns(const SQLString& catalog, const SQLString& schema, const SQLString& table)=0;
  virtual ResultSet* getCrossReference(const SQLString& parentCatalog, const SQLString& parentSchema, const SQLString& parentTable,
                                       const SQLString& foreignCatalog, const SQLString& foreignSchema, const SQLString& foreignTable)=0;
  virtual ResultSet* getTypeInfo()=0;
  virtual ResultSet* getIndexInfo(const SQLString& catalog, const SQLString& schema, const SQLString& table,bool unique,bool approximate)=0;
  virtual bool supportsResultSetType(int32_t type)=0;
  virtual bool supportsResultSetConcurrency(int32_t type,int32_t concurrency)=0;
  virtual bool ownUpdatesAreVisible(int32_t type)=0;
  virtual bool ownDeletesAreVisible(int32_t type)=0;
  virtual bool ownInsertsAreVisible(int32_t type)=0;
  virtual bool othersUpdatesAreVisible(int32_t type)=0;
  virtual bool othersDeletesAreVisible(int32_t type)=0;
  virtual bool othersInsertsAreVisible(int32_t type)=0;
  virtual bool updatesAreDetected(int32_t type)=0;
  virtual bool deletesAreDetected(int32_t type)=0;
  virtual bool insertsAreDetected(int32_t type)=0;
  virtual bool supportsBatchUpdates()=0;
  virtual ResultSet* getUDTs(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& typeNamePattern, std::list<int32_t>& types)=0;
  virtual Connection* getConnection()=0;
  virtual bool supportsSavepoints()=0;
  virtual bool supportsNamedParameters()=0;
  virtual bool supportsMultipleOpenResults()=0;
  virtual bool supportsGetGeneratedKeys()=0;
  virtual ResultSet* getSuperTypes(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& typeNamePattern)=0;
  virtual ResultSet* getSuperTables(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& tableNamePattern)=0;
  virtual ResultSet* getAttributes(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& typeNamePattern, const SQLString& attributeNamePattern)=0;
  virtual bool supportsResultSetHoldability(int32_t holdability)=0;
  virtual int32_t getResultSetHoldability()=0;
  virtual uint32_t getDatabaseMajorVersion()=0;
  virtual uint32_t getDatabaseMinorVersion()=0;
  virtual uint32_t getDatabasePatchVersion()=0;
  virtual uint32_t getJDBCMajorVersion()=0;
  virtual uint32_t getJDBCMinorVersion()=0;
  virtual int32_t getSQLStateType()=0;
  virtual bool locatorsUpdateCopy()=0;
  virtual bool supportsStatementPooling()=0;
  virtual RowIdLifetime getRowIdLifetime()=0;
  virtual bool supportsStoredFunctionsUsingCallSyntax()=0;
  virtual bool autoCommitFailureClosesAllResultSets()=0;
  virtual ResultSet* getClientInfoProperties()=0;
  virtual ResultSet* getFunctions(const SQLString& catalog, const SQLString& schemaPattern, const SQLString& functionNamePattern)=0;
  virtual int64_t getMaxLogicalLobSize()=0;
  virtual bool supportsRefCursors()=0;

  virtual bool supportsTypeConversion()=0;

  virtual ResultSet* getSchemaObjectTypes()=0;
  virtual ResultSet* getSchemaObjects()=0;
  virtual ResultSet* getSchemaObjects(const SQLString& c, const SQLString& s, const SQLString& t)=0;
  virtual uint32_t getCDBCMajorVersion()=0;
  virtual uint32_t getCDBCMinorVersion()=0;
  virtual ResultSet* getSchemaCollation(const SQLString& c, const SQLString& s)=0;
  virtual ResultSet* getSchemaCharset(const SQLString& c, const SQLString& s)=0;
  virtual ResultSet* getTableCollation(const SQLString& c, const SQLString& s, const SQLString& t)=0;
  virtual ResultSet* getTableCharset(const SQLString& c, const SQLString& s, const SQLString& t)=0;
};
}
#endif
