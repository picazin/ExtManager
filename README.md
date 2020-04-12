# Extension Manager for Dynamics 365 Business Central

Extension Manager for Microsoft Dynamics 365 Business Central is a free-to-use app created with the aim to help partners and developers to manage objects in their extensions directly from BC.

## Table of contents

1. Idea
2. How-to
3. Future improvements
4. About

## ***Idea***

The main idea is to help developers when managing and assigning objects IDs when working on several extensions at same time with multiple developers.

Every partner / customer / developer should have control over created objects in order to avoid repeating same number on different extensions. With **EXM** (**EX**tension **M**anager) I'll try to easily assign objects IDs automatically and give to the developer a general view of AL developments.

The app manages 2 types of AL extensions:

**Internal:** Extensions developed per partners with the aim of selling on the app store or to several customers.

**External:** Extensions developed only for an specific customer (formerly a customer project).

## How-to

Once the app is installed on our BC we can find the extension on the menu.

Try typing ***"extension"*** and 2 additional links appear:

![Extension menu](.\images\EXM_Menu.gif)

### Setup

Type ***"extension"*** and select **"Extension Manager Setup"**

![Extension setup](.\images\EXM_Setup.png)

When "Extension Manager Setup" is clicked the setup page opens and these are the available options (ToolTips not yet done):

![Extension setup detail](.\images\EXM_Setup_detail.png)

#### ***General tab***

##### **Extension Nos.**

 Allows to setup a default series no. used when creating a new extension.

##### **Objects Names**

 Allows to show object name or caption when we select them on extension objects details.

##### **Default Starting / Ending Range**

 Set default extension range that will be set when a new extension is created.

#### ***Advanced Options tab***

##### **Disable Auto Objects ID**

 The app proposes the next ID available when selecting an object type. Disabling this option won't validate if set ID is used on current / other extension per same object.

 The proposal system is easy. Looks for next available ID taking care of the extension range and other extensions created depending on extension type. In case of external extension type the proposed ID takes care of all extensions of selected customer.

##### **Disable Auto Field ID**

 Same functionality described above but per fields ID.

### Create new extension

When selecting "Extension Manager" we'll see all of our extensions. Easy way to take a look and select which one to take care or create a new. Standard BC functionality.

![Extension list](.\images\EXM_List.png)

When one selected (or New button) we'll take a look at Extension Card where we'll have available all extension information.

![Extension card](.\images\EXM_Ext_Header.png)

As you can see on the picture the Extension Card is composed by Header and Lines.

#### Header

##### **Code**

 Depending on setup. If "no. series" set the extension code works as standard documents code.

##### **Description**

 Just describe the extension

##### **Type** (Allowed values)

 ***Internal***

  Extension developed per partners with the aim of selling on the app store or to several customers.

 ***External***

  Extension developed only for an specific customer (formerly a customer project).

 If Type is set to External customer must be selected

##### **Starting / Ending No.**

 IDs set to create IDs when defining objects

##### **GIT Repository URL**

 URL where extension objects are stored

#### Lines

It's really easy to use. You select the object type you're creating and Object ID is automatically set.

**Object Name** must be set

In case you're selecting ***TableExtension***, ***PageExtension***, ***EnumExtension*** or ***ProfileExtension*** the field Source ***Object Type*** is filled.

**Source Object ID** must be filled. Once selected the Name is set depending to your setup choice (Name or Caption)

![Auto object ID](.\images\EXM_Auto_Object_ID.gif)

### Set extension objects

When working with ***Table***, ***TableExtension***, ***Enum*** or ***EnumExtension*** fields details must be set.

In order to fill the field data information we can select ***Total Fields*** or ***Manage - Fields*** and a new page where we can input or check fields related data

![Fields detail](.\images\EXM_Ext_Detail_Table.png)

As you can see in the following images, there are 2 option available

#### **View / Hide fields**

 Allow to show other fields set on same table when creating a new ***TableExtension***

![View extended fields](.\images\EXM_View_Ext_Same_Table.gif)

#### **View source table**

 Allows to see all fields on source table

![View source table](.\images\EXM_View_Source_Table.gif)

## Future improvements

- [ ] Include Enums values detail
- [ ] Create specific role for **EXM**. Also include as profile extensions to IT role.
- [ ] Guided setup
- [ ] Financial management

## About

Andreu + Olivia + Contacte + suggeriments + bugs
