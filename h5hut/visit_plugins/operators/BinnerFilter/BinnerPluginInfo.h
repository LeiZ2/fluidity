// ************************************************************************* //
//  File: BinnerPluginInfo.h
// ************************************************************************* //

#ifndef BINNER_PLUGIN_INFO_H
#define BINNER_PLUGIN_INFO_H
#include <OperatorPluginInfo.h>
#include <operator_plugin_exports.h>

class Binner;

// ****************************************************************************
//  Class: BinnerPluginInfo
//
//  Purpose:
//    Five classes that provide all the information about an Binner operator
//
//  Programmer: cristina -- generated by xml2info
//  Creation:   Thu Mar 30 12:05:26 PDT 2006
//
//  Modifications:
//
// ****************************************************************************

class BinnerGeneralPluginInfo : public virtual GeneralOperatorPluginInfo
{
public:
	virtual char *GetName() const;
	virtual char *GetVersion() const;
	virtual char *GetID() const;
	virtual bool  EnabledByDefault() const;
};

class BinnerCommonPluginInfo : public virtual CommonOperatorPluginInfo, public virtual BinnerGeneralPluginInfo
{
public:
	virtual AttributeSubject *AllocAttributes();
	virtual void CopyAttributes(AttributeSubject *to, AttributeSubject *from);
};

class BinnerGUIPluginInfo : public virtual GUIOperatorPluginInfo, public virtual BinnerCommonPluginInfo
{
public:
	virtual const char *GetMenuName() const;
	virtual QvisPostableWindowObserver *CreatePluginWindow(int type,
	                                                       AttributeSubject *attr, QvisNotepadArea *notepad);
	virtual const char **XPMIconData() const;
};

class BinnerViewerPluginInfo : public virtual ViewerOperatorPluginInfo, public virtual BinnerCommonPluginInfo
{
public:
	virtual AttributeSubject *GetClientAtts();
	virtual AttributeSubject *GetDefaultAtts();
	virtual void SetClientAtts(AttributeSubject *atts);
	virtual void GetClientAtts(AttributeSubject *atts);

	virtual void InitializeOperatorAtts(AttributeSubject *atts,
	                                    const ViewerPlot *plot,
	                                    const bool fromDefault);
	virtual const char **XPMIconData() const;

	static void InitializeGlobalObjects();
private:
	static Binner *defaultAtts;
	static Binner *clientAtts;
};

class BinnerEnginePluginInfo : public virtual EngineOperatorPluginInfo, public virtual BinnerCommonPluginInfo
{
public:
	virtual avtPluginFilter *AllocAvtPluginFilter();
};

class BinnerScriptingPluginInfo : public virtual ScriptingOperatorPluginInfo, public virtual BinnerCommonPluginInfo
{
public:
	virtual void InitializePlugin(AttributeSubject *subj, void *data);
	virtual void *GetMethodTable(int *nMethods);
	virtual bool TypesMatch(void *pyobject);
	virtual char *GetLogString();
	virtual void SetDefaults(const AttributeSubject *atts);
};

#endif