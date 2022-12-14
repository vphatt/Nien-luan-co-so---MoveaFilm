// ignore_for_file: unused_field, prefer_final_fields, must_call_super, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/movie.dart';
import '../shared/dialog_utils.dart';

import 'movies_manager.dart';

class EditMovieScreen extends StatefulWidget {
  static const routeName = 'edit-movie';

  EditMovieScreen(
    Movie? movie, {
    super.key,
  }) {
    if (movie == null) {
      this.movie = Movie(
          id: null,
          title: '',
          description: '',
          category: '',
          nation: '',
          imageUrl: '',
          videoUrl: '',
          imdb: 0.0,
          duration: '',
          cast: '',
          year: 2000,
          director: '');
    } else {
      this.movie = movie;
    }
  }

  late final Movie movie;

  @override
  State<EditMovieScreen> createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Movie _editedMovie;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  bool _isValidVideoUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
      }
    });
    _editedMovie = widget.movie;
    _imageUrlController.text = _editedMovie.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final moviesManager = context.read<MoviesManager>();
      if (_editedMovie.id != null) {
        await moviesManager.updateMovie(_editedMovie);
      } else {
        await moviesManager.addMovie(_editedMovie);
      }
    } catch (error) {
      await showErrorDialog(context, "???? x???y ra l???i.");
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _saveForm,
            label: RichText(
              text: TextSpan(children: [
                WidgetSpan(
                    child: Icon(
                  (_editedMovie.id == null) ? Icons.add : Icons.edit,
                  color: Colors.white,
                  size: 20,
                )),
                TextSpan(
                    text: (_editedMovie.id == null) ? ' Th??m' : ' C???p nh???t',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Quicksand'))
              ]),
            )),
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
          title: Text(
            (_editedMovie.id == null) ? 'Th??m Phim M???i' : 'Ch???nh S???a Phim',
            style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _editForm,
                  child: ListView(children: <Widget>[
                    buildTitleField(),
                    buildDescriptionField(),
                    buildCategoryField(),
                    buildNationField(),
                    buildImagePreview(),
                    buildVideoField(),
                    buildIMDBField(),
                    buildDurationField(),
                    buildDirectorField(),
                    buildCastField(),
                    buildYearField()
                  ]),
                )));
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedMovie.title,
      decoration: const InputDecoration(
          labelText: 'T??n phim:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p t??n phim.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(title: value);
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedMovie.description,
      decoration: const InputDecoration(
          labelText: "M?? t??? phim:",
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p m?? t???.";
        }
        if (value.length < 10) {
          return "M?? t??? ph???i nhi???u h??n 10 k?? t???.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(description: value);
      },
    );
  }

  TextFormField buildCategoryField() {
    return TextFormField(
      initialValue: _editedMovie.category,
      decoration: const InputDecoration(
          labelText: 'Th??? lo???i:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p th??? lo???i.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(category: value);
      },
    );
  }

  TextFormField buildNationField() {
    return TextFormField(
      initialValue: _editedMovie.nation,
      decoration: const InputDecoration(
          labelText: 'Qu???c gia:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p t??n Qu???c gia.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(nation: value);
      },
    );
  }

  Widget buildImagePreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(top: 8, right: 10),
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.grey,
            )),
            child: _imageUrlController.text.isEmpty
                ? const Text("Nh???p URL ???nh:")
                : FittedBox(
                    child: Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                    ),
                  )),
        Expanded(
          child: buildImageURLField(),
        )
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "URL ???nh",
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p URL ???nh.";
        }
        if (!_isValidImageUrl(value)) {
          return "URL kh??ng h???p l???.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(imageUrl: value);
      },
    );
  }

  TextFormField buildVideoField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Video URL",
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p URL.";
        }
        if (!_isValidVideoUrl(value)) {
          return "URL kh??ng h???p l???.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(videoUrl: value);
      },
    );
  }

  TextFormField buildIMDBField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "??i???m IMDB:",
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p ??i???m IMDB.";
        }
        if (double.tryParse(value) == null) {
          return "Vui l??ng nh???p gi?? tr??? h???p l???.";
        }
        if (double.parse(value) <= 0 && double.parse(value) > 10) {
          return "??i???m h???p l??? khi c?? gi?? tr??? t??? 0 ?????n 10.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(imdb: double.parse(value!));
      },
    );
  }

  TextFormField buildDurationField() {
    return TextFormField(
      initialValue: _editedMovie.duration,
      decoration: const InputDecoration(
          labelText: 'Th???i l?????ng:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p th???i l?????ng phim.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(duration: value);
      },
    );
  }

  TextFormField buildCastField() {
    return TextFormField(
      initialValue: _editedMovie.cast,
      decoration: const InputDecoration(
          labelText: 'Di???n vi??n:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p di???n vi??n.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(cast: value);
      },
    );
  }

  TextFormField buildDirectorField() {
    return TextFormField(
      initialValue: _editedMovie.director,
      decoration: const InputDecoration(
          labelText: '?????o di???n:',
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui l??ng nh???p t??n ?????o di???n.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(director: value);
      },
    );
  }

  TextFormField buildYearField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "N??m ph??t h??nh:",
          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        DateTime nowDate = DateTime.now();
        int nowYear = nowDate.year;
        if (value!.isEmpty) {
          return "Vui l??ng nh???p N??m ph??t h??nh.";
        }
        if (double.tryParse(value) == null) {
          return "Vui l??ng nh???p gi?? tr??? h???p l???.";
        }
        if (double.parse(value) <= 1990 && double.parse(value) > nowYear) {
          return "N??m kh??ng h???p l???.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovie = _editedMovie.copyWith(year: int.parse(value!));
      },
    );
  }
}
