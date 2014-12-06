%define profile wearable

Summary:	Tizen Wearable Package Groups and Image Configurations
Name:		meta-wearable
Version:	003
Release:	1
License:	GPL-2.0
Group:		System/Base
URL:		http://www.tizen.org
Source:		%{name}-%{version}.tar.bz2

%description
Tizen Wearable Package Groups and Image Configurations

%prep
%setup -q

%build
make 

%install
%make_install


%files
%{_datadir}/package-groups/wearable/*.yaml
%{_datadir}/image-configurations/wearable/*.yaml
%{_datadir}/image-configurations/wearable/configs/*.yaml
%{_datadir}/image-configurations/wearable/scripts
%{_datadir}/image-configurations/wearable/partitions
