// ignore_for_file: unused_field, prefer_final_fields, must_call_super, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/movie_comingsoon.dart';
import '../../../shared/dialog_utils.dart';
import 'movies_coming_manager.dart';

class EditMovieComingScreen extends StatefulWidget {
  static const routeName = 'edit-movie-coming';

  EditMovieComingScreen(
    MovieComingSoon? movieComing, {
    super.key,
  }) {
    if (movieComing == null) {
      this.movieComing = MovieComingSoon(
          id: null,
          title: '',
          description: '',
          category: '',
          nation: '',
          imageUrl: '',
          trailerUrl: '',
          cast: '',
          premiere: '',
          director: '');
    } else {
      this.movieComing = movieComing;
    }
  }

  late final MovieComingSoon movieComing;

  @override
  State<EditMovieComingScreen> createState() => _EditMovieComingScreenState();
}

class _EditMovieComingScreenState extends State<EditMovieComingScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late MovieComingSoon _editedMovieComing;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  bool _isValidTrailerUrl(String value) {
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
    _editedMovieComing = widget.movieComing;
    _imageUrlController.text = _editedMovieComing.imageUrl;
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
      final moviesComingManager = context.read<MoviesComingManager>();
      if (_editedMovieComing.id != null) {
        await moviesComingManager.updateMovieComing(_editedMovieComing);
      } else {
        await moviesComingManager.addMovieComing(_editedMovieComing);
      }
    } catch (error) {
      await showErrorDialog(context, "Đã xảy ra lỗi.");
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
                  (_editedMovieComing.id == null) ? Icons.add : Icons.edit,
                  color: Colors.white,
                  size: 20,
                )),
                TextSpan(
                    text:
                        (_editedMovieComing.id == null) ? ' Thêm' : ' Cập nhật',
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
            (_editedMovieComing.id == null)
                ? 'Thêm Phim Mới'
                : 'Chỉnh Sửa Phim',
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
                    buildTrailerField(),
                    buildDirectorField(),
                    buildCastField(),
                    buildPremiereField()
                  ]),
                )));
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedMovieComing.title,
      decoration: const InputDecoration(labelText: 'Tên phim:'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập tên phim.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(title: value);
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedMovieComing.description,
      decoration: const InputDecoration(labelText: "Mô tả phim:"),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập mô tả.";
        }
        if (value.length < 10) {
          return "Mô tả phải nhiều hơn 10 kí tự.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(description: value);
      },
    );
  }

  TextFormField buildCategoryField() {
    return TextFormField(
      initialValue: _editedMovieComing.category,
      decoration: const InputDecoration(labelText: 'Thể loại:'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập thể loại.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(category: value);
      },
    );
  }

  TextFormField buildNationField() {
    return TextFormField(
      initialValue: _editedMovieComing.nation,
      decoration: const InputDecoration(labelText: 'Quốc gia:'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập tên Quốc gia.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(nation: value);
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
                ? const Text("Nhập URL ảnh:")
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
      decoration: const InputDecoration(labelText: "URL ảnh"),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập URL ảnh.";
        }
        if (!_isValidImageUrl(value)) {
          return "URL không hợp lệ.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(imageUrl: value);
      },
    );
  }

  TextFormField buildTrailerField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Trailer URL"),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập URL.";
        }
        if (!_isValidTrailerUrl(value)) {
          return "URL không hợp lệ.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(trailerUrl: value);
      },
    );
  }

  TextFormField buildCastField() {
    return TextFormField(
      initialValue: _editedMovieComing.cast,
      decoration: const InputDecoration(labelText: 'Diễn viên:'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập diễn viên.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(cast: value);
      },
    );
  }

  TextFormField buildDirectorField() {
    return TextFormField(
      initialValue: _editedMovieComing.director,
      decoration: const InputDecoration(labelText: 'Đạo diễn:'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập tên đạo diễn.";
        }
        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(director: value);
      },
    );
  }

  TextFormField buildPremiereField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Công chiếu:"),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return "Vui lòng nhập thời gian công chiếu.";
        }

        return null;
      },
      onSaved: (value) {
        _editedMovieComing = _editedMovieComing.copyWith(premiere: value);
      },
    );
  }
}
